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
      :'mj-customid', :'mj-eventpayload', :vars, :headers
    )
  end

  def deliver!(mail)
    content = {}

    if mail.text_part
      if (@version == 'v3.1')
        content[:TextPart] = mail.text_part.try(:decoded)
      else
        content[:text_part] = mail.text_part.try(:decoded)
      end
      content[:text] = mail.text_part.try(:decoded)
    end

    if mail.html_part
      if (@version == 'v3.1')
        content[:HTMLPart] = mail.html_part.try(:decoded)
      else
        content[:html_part] = mail.html_part.try(:decoded)
      end
      content[:html] = mail.html_part.try(:decoded)
    end

    # Formatting attachments (inline + regular)
    unless mail.attachments.empty?
      if (@version == 'v3.1')
        content[:Attachments] = []
        content[:InlineAttachments] = []
      else
        content[:attachments] = []
        content[:inline_attachments] = []
      end

      mail.attachments.each do |attachment|
        mailjet_attachment = {
          'Content-Type' => attachment.content_type.split(';')[0],
          'Filename' => attachment.filename,
          'content' => Base64.encode64(attachment.body.decoded)
        }

        if attachment.inline?
          if (@version == 'v3.1')
            content[:InlineAttachments].push(mailjet_attachment)
          else
            content[:inline_attachments].push(mailjet_attachment)
          end
        else
          if (@version == 'v3.1')
            content[:Attachments].push(mailjet_attachment)
          else
            content[:attachments].push(mailjet_attachment)
          end
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
    if mail.reply_to
      if (@version == 'v3.1')
        content['ReplyTo'] = {"Email"=> mail.reply_to.join(', ')}
      else
        content[:headers]['Reply-To'] = mail.reply_to.join(', ')
      end
    end

    # Mailjet Send API does not support full from. Splitting the from field into two: name and email address
    if mail[:from].nil? && Mailjet.config.default_from.present?
      mail[:from] = Mailjet.config.default_from
    end

    # Send the final payload to Mailjet Send API
    Mailjet::Send.create({"Messages"=> [setPayload(mail, content)]})
  end

  def setPayload(mail, content)
    if (@version == "v3.1")
      if (mail[:to])
        if (mail[:to].is_a? String)
          to = [{'Email'=>mail[:to].data.raw}]
        else
          to = []
          mail[:to].each do |t|
            to << {'Email'=> t}
          end
        end
      end
      payload = {
        "To"=> to,
        "Sender"=> mail[:sender],
        "Subject"=> mail.subject
      }
    else
      payload = {
        to: mail[:to].formatted.join(', '),
        sender: mail[:sender],
        subject: mail.subject
      }
    end
    .merge(content)
    .merge(setFrom(mail))
    .merge(@delivery_method_options)
    
    if (@version == "v3.1")
      if (mail[:cc])
        if (mail[:cc].is_a? String)
          payload["Cc"] = [{'Email'=>mail[:cc]}]
        else
          ccs = []
          mail[:cc].each do |cc|
            ccs << {'Email'=> cc}
          end
          payload['Cc'] = ccs
        end
      end
      if (mail[:bcc])
        if (mail[:bcc].is_a? String)
          payload["Bcc"] = [{'Email'=>mail[:bcc]}]
        else
          bccs = []
          mail[:bcc].each do |bcc|
            bccs << {'Email'=> bcc}
          end
          payload['Bcc'] = bccs
        end
      end
    else
      payload[:cc] = mail[:cc].formatted.join(', ') if mail[:cc]
      payload[:bcc] = mail[:bcc].formatted.join(', ') if mail[:bcc]
    end
    payload
  end

  def setFrom(mail)
    if (@version == "v3.1")
      base_from = {
        From:{
          "Email"=> mail[:from].addresses.first,
          "Name"=> mail[:from].display_names.first
        }
      }
    else
      base_from = {
        from_name: mail[:from].display_names.first,
        from_email: mail[:from].addresses.first
      }
    end
    base_from
  end
end

ActionMailer::Base.add_delivery_method :mailjet_api, Mailjet::APIMailer
