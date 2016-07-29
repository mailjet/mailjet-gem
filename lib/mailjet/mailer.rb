require 'action_mailer'
require 'mail'
require 'base64'
require 'json'

# Mailjet::Mailer enables to send a Mail::Message via Mailjet SMTP relay servers
# User is the API key, and password the API secret
class Mailjet::Mailer < ::Mail::SMTP
  def initialize(options = {})
    ActionMailer::Base.default(:from => Mailjet.config.default_from) if Mailjet.config.default_from.present?
    super({
      :address  => "in-v3.mailjet.com",
      :port  => 587,
      :authentication  => 'plain',
      :user_name => Mailjet.config.api_key,
      :password  => Mailjet.config.secret_key,
      :enable_starttls_auto => true
    }.merge(options))
  end
end

ActionMailer::Base.add_delivery_method :mailjet, Mailjet::Mailer

# Mailjet::APIMailer maps a Mail::Message coming from ActionMailer
# To Mailjet Send API (see full documentation here dev.mailjet.com/guides/#send-transactional-email)
# Mailjet sends API expects a JSON payload as the input.
# The deliver methods maps the Mail::Message attributes to the MailjetSend API JSON expected structure
class Mailjet::APIMailer
  def initialize(options = {})
    @delivery_method_options = options.slice(:'mj-prio', :'mj-campaign', :'mj-deduplicatecampaign', :'mj-trackopen', :'mj-trackclick', :'mj-customid', :'mj-eventpayload', :'header')
  end

  def deliver!(mail)
    content = {}

    if  mail.text_part
      content[:text_part] = mail.text_part.body.decoded
    end

    if mail.html_part
      content[:html_part] = mail.html_part.body.decoded
    end

    # Formatting attachments (inline + regular)
    if !mail.attachments.empty?
      content[:attachments] = []
      content[:inline_attachments] = []

      mail.attachments.each do |attachment|
        mailjet_attachment = {
          'Content-Type' => attachment.content_type.split(';')[0],
          'Filename' => attachment.filename,
          'content' => Base64.encode64(attachment.body.decoded)
        }

        if attachment.inline?
          content[:inline_attachments].push(mailjet_attachment)
        else
          content[:attachments].push(mailjet_attachment)
        end
      end
    end

    # Formatting headers. Passing only the ones starting with X-MJ / X-Mailjet.
    if not mail.header.fields.empty?
      content[:headers] = {}
      mail.header.fields.each do |header|
        if header.name.start_with?('X-MJ') or header.name.start_with?('X-Mailjet')
          content[:headers][header.name] = header.value
        end
      end
    end

    # Mailjet Send API does not support full from. Splitting the from field into two: name and email address
    if Mailjet.config.default_from.present?
      from_address = Mail::AddressList.new(Mailjet.config.default_from).addresses[0]
    else
      from_address = Mail::AddressList.new(mail.from.join(', ')).addresses[0]
    end

    base_from = { :from_name => from_address.display_name,
                  :from_email => from_address.address }

  	payload = {
      :to => mail.to.join(', '),
      :reply_to => mail.reply_to,
      :cc => mail.cc.join(', '),
      :bcc => mail.bcc.join(', '),
      :subject => mail.subject
  	}
    .merge(content)
    .merge(base_from)
    .merge(@delivery_method_options)

    # Send the final payload to Mailjet Send API
  	Mailjet::Send.create(payload)
	end
end

ActionMailer::Base.add_delivery_method :mailjet_api, Mailjet::APIMailer
