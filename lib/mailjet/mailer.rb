require 'action_mailer'
require 'mail'
require 'base64'
require 'json'

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



class Mailjet::APIMailer
  def initialize(options = {})
    @delivery_method_options = options.slice(:'mj-prio', :'mj-campaign', :'mj-deduplicatecampaign', :'mj-trackopen', :'mj-trackclick', :'mj-customid', :'mj-eventpayload', :'header')
  end

  def deliver!(mail)
    content = {}

    if mail.text_part
      content[:text_part] = mail.text_part.try(:decoded)
      content[:text] = mail.text_part.try(:decoded)
    end

    if mail.html_part
      content[:html_part] = mail.html_part.try(:decoded)
      content[:html] = mail.html_part.try(:decoded)
    end

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

		if mail.header and not mail.header.fields.empty?
		 content[:headers] = {}
		 mail.header.fields.each do |header|
			 if header.name.start_with?('X-MJ') or header.name.start_with?('X-Mailjet')
				 content[:headers][header.name] = header.value
			 end
		 end
		end

    if Mailjet.config.default_from.present?
      # from_address = Mail::AddressList.new(Mailjet.config.default_from).addresses[0]
			mail[:from] = Mailjet.config.default_from
    end

    base_from = { :from_name => mail[:from].display_names.first,
                  :from_email => mail[:from].addresses.first }

  	payload = {
      :to => mail[:to].formatted.join(', '),
      :subject => mail.subject
  	}
    .merge(content)
    .merge(base_from)
    .merge(@delivery_method_options)

		payload[:cc] = mail[:cc].formatted.join(', ') if mail[:cc]
		payload[:reply_to] = mail[:reply_to].formatted.join(', ') if mail[:reply_to]
		payload[:bcc] = mail[:bcc].formatted.join(', ') if mail[:bcc]

  	Mailjet::Send.create(payload)

  	end
end

ActionMailer::Base.add_delivery_method :mailjet_api, Mailjet::APIMailer
