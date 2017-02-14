require 'action_mailer'
require 'mail'
require 'base64'
require 'json'

# Mailjet::Mailer enables to send a Mail::Message via Mailjet SMTP relay servers
# User is the API key, and password the API secret
class Mailjet::Mailer < ::Mail::SMTP
  def initialize(options = {})
    ActionMailer::Base.default(from: Mailjet.config.default_from) if Mailjet.config.default_from.present?
    super({
      address: 'in-v3.mailjet.com',
      port: 587,
      authentication: 'plain',
      user_name: Mailjet.config.api_key,
      password: Mailjet.config.secret_key,
      enable_starttls_auto: true
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
#    send = Mailjet.Send.new
#    if send.version.exists
#      version = send.version
#    else
      @version = Mailjet.config.api_version
#    end
    @delivery_method_options = options.slice(
      :recipients, :'mj-prio', :'mj-campaign', :'mj-deduplicatecampaign',
      :'mj-templatelanguage', :'mj-templateerrorreporting', :'mj-templateerrordeliver', :'mj-templateid',
      :'mj-trackopen', :'mj-trackclick',
      :'mj-customid', :'mj-eventpayload', :vars, :headers,
    )
    @delivery_method_options_v3_1 = options.slice(
      :recipients, :'prio', :'campaign', :'deduplicatecampaign',
      :'templatelanguage', :'templateerrorreporting', :'templateerrordeliver', :'templateid',
      :'trackopen', :'trackclick',
      :'customid', :'eventpayload', :vars, :headers,
    )
  end

  def deliver!(mail, options = nil)
#    p mail.header.fields
    
    if (options && options.kind_of?(Object) && options['version'].present?)
      @version = options['version']
    end
    
    if (!options.kind_of?(Object))
      options = []
    end

    # Mailjet Send API does not support full from. Splitting the from field into two: name and email address
    if mail[:from].nil? && Mailjet.config.default_from.present?
      mail[:from] = Mailjet.config.default_from
    end

    if (@version == 'v3.1')
      Mailjet::Send.create({:Messages => setContentV3_1(mail)})
    else
      Mailjet::Send.create(setContentV3(mail))
    end
  end

  def setContentV3_1(mail)
    content = {}
    content[:TextPart] = mail.text_part.try(:decoded)
    content[:HTMLPart] = mail.html_part.try(:decoded)
    
    unless mail.attachments.empty?
      content[:Attachments] = []
      content[:InlineAttachments] = []

      mail.attachments.each do |attachment|
        mailjet_attachment = {
          'ContentType' => attachment.content_type.split(';')[0],
          'Filename' => attachment.filename,
          'content' => Base64.encode64(attachment.body.decoded)
        }

        if attachment.inline?
          mailjet_attachment['ContentId'] = attachment.content_id
          content[:InlineAttachments].push(mailjet_attachment)
        else
          content[:Attachments].push(mailjet_attachment)
        end
      end
    end

    if mail.header && !mail.header.fields.empty?
      content[:headers] = {}
      mail.header.fields.each do |header|
        if header.name.start_with?('X-') && !header.name.start_with?('X-MJ') && !header.name.start_with?('X-Mailjet')
          content[:headers][header.name] = header.value
        end
      end
    end

    # Reply-To is not a property in Mailjet Send API
    # Passing it as an header
    content[:headers]['Reply-To'] = {:Email=> mail[:reply_to].addresses.first,
      :Name=> [:reply_to].display_names.first,} if mail.reply_to
    
    if (mail[:to])
      if (mail[:to].is_a? String)
        to = [{:Email=>mail[:to].addresses.first, :Name=>mail[:to].display_names.first}]
      else
        to = []
        mail[:to].each do |t|
          to << {:Email=> t.address, :Name=>t.display_name}
        end
      end
    end
    
    base_from = {
      From:{
        :Email=> mail[:from].addresses.first
      }
    }
    if (mail[:from].display_names.first)
      base_from[:From][:Name] = mail[:from].display_names.first
    end
    
    payload = {
      :To=> to,
      :Sender=> mail[:sender],
      :Subject=> mail.subject
    }.merge(content)
    .merge(base_from)
    .merge(@delivery_method_options_v3_1)
  
    if (mail[:cc])
      if (mail[:cc].is_a? String)
        payload["Cc"] = [{'Email'=>mail[:cc]}]
      else
        ccs = []
        mail[:cc].each do |cc|
          ccs << {:Email=> cc}
        end
        payload[:Cc] = ccs
      end
    end
    if (mail[:bcc])
      if (mail[:bcc].formatted.is_a? String)
        payload[:Bcc] = [{:Email=>mail[:bcc]}]
      else
        bccs = []
        mail[:bcc].formatted.each do |bcc|
          bccs << {:Email=> bcc}
        end
        payload[:Bcc] = bccs
      end
    end
    payload
    
  end
  
  def setContentV3(mail)
    content = {}

    if mail.text_part
      content[:text_part] = mail.text_part.try(:decoded)
      content[:text] = mail.text_part.try(:decoded)
    end

    if mail.html_part
      content[:html_part] = mail.html_part.try(:decoded)
      content[:html] = mail.html_part.try(:decoded)
    end

    # Formatting attachments (inline + regular)
    unless mail.attachments.empty?
      content[:attachments] = []
      content[:inline_attachments] = []

      mail.attachments.each do |attachment|
        mailjet_attachment = {
          'Content-Type' => attachment.content_type.split(';')[0],
          'Filename' => attachment.filename,
          'content' => Base64.encode64(attachment.body.decoded)
        }

        if attachment.inline?
#          mailjet_attachment['Content-Id'] = attachment.content_id
          content[:inline_attachments].push(mailjet_attachment)
        else
          content[:attachments].push(mailjet_attachment)
        end
      end
    end

    if mail.header && !mail.header.fields.empty?
      content[:headers] = {}
      mail.header.fields.each do |header|
        if header.name.start_with?('X-MJ') || header.name.start_with?('X-Mailjet')
          content[:headers][header.name] = header.value
        end
      end
    end

    # Reply-To is not a property in Mailjet Send API
    # Passing it as an header
    content[:headers]['Reply-To'] = mail.reply_to.join(', ') if mail.reply_to

    # Mailjet Send API does not support full from. Splitting the from field into two: name and email address
    if mail[:from].nil? && Mailjet.config.default_from.present?
      mail[:from] = Mailjet.config.default_from
    end

    base_from = { from_name: mail[:from].display_names.first,
                  from_email: mail[:from].addresses.first }
        
    payload = {
      to: mail[:to].formatted.join(', '),
      sender: mail[:sender],
      subject: mail.subject
    }
    .merge(content)
    .merge(base_from)
    .merge(@delivery_method_options)

    payload[:cc] = mail[:cc].formatted.join(', ') if mail[:cc]
    payload[:reply_to] = mail[:reply_to].formatted.join(', ') if mail[:reply_to]
    payload[:bcc] = mail[:bcc].formatted.join(', ') if mail[:bcc]

    # Send the final payload to Mailjet Send API
    payload
  end
end

ActionMailer::Base.add_delivery_method :mailjet_api, Mailjet::APIMailer
