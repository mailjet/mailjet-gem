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
      user_name: options.delete(:api_key) || Mailjet.config.api_key,
      password: options.delete(:secret_key) || Mailjet.config.secret_key,
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
  V3_0_PERMITTED_OPTIONS = [
    :recipients, :'mj-prio', :'mj-campaign', :'mj-deduplicatecampaign',
    :'mj-templatelanguage', :'mj-templateerrorreporting', :'mj-templateerrordeliver', :'mj-templateid',
    :'mj-trackopen', :'mj-trackclick',
    :'mj-customid', :'mj-eventpayload', :vars, :headers,
  ]

  V3_1_PERMITTED_OPTIONS = [
    :'Priority', :'CustomCampaign', :'DeduplicateCampaign',
    :'TemplateLanguage', :'TemplateErrorReporting', :'TemplateErrorDeliver', :'TemplateID',
    :'TrackOpens', :'TrackClicks',
    :'CustomID', :'EventPayload', :'Variables', :'Headers',
  ]

  CONNECTION_PERMITTED_OPTIONS = [:api_key, :secret_key]

  def initialize(opts = {})
    options = HashWithIndifferentAccess.new(opts)

    @version = options[:version]
    @delivery_method_options_v3_0 = options.slice(*V3_0_PERMITTED_OPTIONS)
    @delivery_method_options_v3_1 = options.slice(*V3_1_PERMITTED_OPTIONS)
    @connection_options = options.slice(*CONNECTION_PERMITTED_OPTIONS)
  end

  def deliver!(mail, opts = {})
    options = HashWithIndifferentAccess.new(opts)

    # Mailjet Send API does not support full from. Splitting the from field into two: name and email address
    mail[:from] ||= Mailjet.config.default_from if Mailjet.config.default_from

    # add `@connection_options` in `options` only if not exist yet (values in `options` prime)
    options.reverse_merge!(@connection_options)

    # add `@version` in options if set
    options[:version] = @version if @version

    # `options[:version]` primes on global config
    version = options[:version] || Mailjet.config.api_version

    if (version == 'v3.1')
      Mailjet::Send.create({ :Messages => [setContentV3_1(mail)] }, options)
    else
      Mailjet::Send.create(setContentV3_0(mail), options)
    end
  end

  def setContentV3_1(mail)
    content = {}

    content[:TextPart] = mail.text_part.try(:decoded) if !mail.text_part.blank?
    content[:HTMLPart] = mail.html_part.try(:decoded) if !mail.html_part.blank?

    # try message `body` as fallback if no content found
    unless content[:TextPart] || content[:HTMLPart] || mail.body.try(:raw_source).empty?
      content[mail.content_type.try(:include?,'text/html') ? :HTMLPart : :TextPart] = mail.body.raw_source
    end


    if mail.attachments.any?
      content[:Attachments] = []
      content[:InlinedAttachments] = []

      mail.attachments.each do |attachment|
        mailjet_attachment = {
          'ContentType' => attachment.content_type.split(';')[0],
          'Filename' => attachment.filename,
          'Base64Content' => Base64.encode64(attachment.body.decoded)
        }

        if attachment.inline?
          mailjet_attachment['ContentId'] = attachment.content_id
          content[:InlinedAttachments].push(mailjet_attachment)
        else
          content[:Attachments].push(mailjet_attachment)
        end
      end
    end

    # We do the next part in purpose to accept only custom header from the user, but without accepting the mailjet related ones
    # The mailjet related ones are stocked in another variable and directly added to the body
    if mail.header && mail.header.fields.any?
      content[:Headers] = {}
      mail.header.fields.each do |header|
        if header.name.start_with?('X-') && !header.name.start_with?('X-MJ') && !header.name.start_with?('X-Mailjet')
          content[:Headers][header.name] = header.value
        end
      end
    end

    # ReplyTo property was added in v3.1
    # Passing it as an header if mail.reply_to

    if mail.reply_to
      if mail.reply_to.respond_to?(:display_names) && mail.reply_to.display_names.first
        content[:ReplyTo] = {:Email=> mail[:reply_to].addresses.first, :Name=> mail[:reply_to].display_names.first}
      else
        content[:ReplyTo] = {:Email=> mail[:reply_to].addresses.first}
      end
    end

    if (mail[:to])
      if (mail[:to].is_a? String)
        if mail[:to].display_names.first
          to = [{:Email=>mail[:to].addresses.first, :Name=>mail[:to].display_names.first}]
        else
          to = [{:Email=>mail[:to].addresses.first}]
        end
      else
        to = []
        mail[:to].each do |t|
          if (t.display_name)
            to << { :Email => t.address, :Name => t.display_name }
          else
            to << { :Email => t.address }
          end
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

    if (mail[:cc])
      if (mail[:cc].is_a? String)
        if mail[:cc].display_name.first
          ccs =[{:Email=>mail[:cc].address.first, :Name=>mail[:cc].display_name.first}]
        else
          ccs =[{:Email=>mail[:cc].address.first}]
        end
      else
        mail[:cc].each do |cc|
          ccs << {:Email=> cc.address, :Name=>cc.display_name}
        end
      end
    end

    if (mail[:bcc])
      if (mail[:bcc].formatted.is_a? String)
        if mail[:bcc].display_name.first
          payload[:Bcc] = [{:Email=>mail[:bcc].address.first, :Name=>mail[:bcc].display_name.first}]
        else
          payload[:Bcc] = [{:Email=>mail[:bcc].address.first}]
        end
      else
        mail[:bcc].formatted.each do |bcc|
          if bcc.display_name
            bccs << {:Email=> bcc.address, :Name=>bcc.display_name}
          else
            bccs << {:Email=> bcc.address}
          end
        end
      end
    end

    payload = {
      :To=> to,
    }.merge(content)
    .merge(base_from)
    .merge(@delivery_method_options_v3_1)

    payload[:Subject] = mail.subject if !mail.subject.blank?
    payload[:Sender] = mail[:sender] if !mail[:sender].blank?
    payload[:Cc] = ccs if mail[:cc]
    payload[:Bcc] = bccs if mail[:bcc]

    payload
  end

  def setContentV3_0(mail)
    content = {}

    content[:text_part] = mail.text_part.try(:decoded) if !mail.text_part.blank?
    content[:html_part] = mail.html_part.try(:decoded) if !mail.html_part.blank?

    # try message `body` as fallback if no content found
    unless content[:text_part] || content[:html_part] || mail.body.try(:raw_source).empty?
      content[mail.content_type.try(:include?,'text/html') ? :html_part : :text_part] = mail.body.raw_source
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
          content[:inline_attachments].push(mailjet_attachment)
        else
          content[:attachments].push(mailjet_attachment)
        end
      end
    end

    # We do the next part in purpose to accept only custom header from the user, but without accepting the mailjet related ones
    # The mailjet related ones are stocked in another variable and directly added to the body
    if mail.header && !mail.header.fields.empty?
      content[:headers] = {}
      mail.header.fields.each do |header|
        content[:headers][header.name] = header.value if header.name =~ /^X-(?!\b(MJ|Mailjet)\b).*$/
      end
    end

    # Reply-To is not a property in Mailjet Send API
    # Passing it as an header
    content[:headers]['Reply-To'] = mail.reply_to.join(', ') if mail.reply_to

    # Mailjet Send API does not support full from. Splitting the from field into two: name and email address
    mail[:from] ||= Mailjet.config.default_from

    base_from = { from_name: mail[:from].display_names.first,
                  from_email: mail[:from].addresses.first }

    payload = {
      to: mail[:to].formatted.join(', '),
      sender: mail[:sender],
      subject: mail.subject
    }

    payload[:cc] = mail[:cc].formatted.join(', ') if mail[:cc]
    payload[:reply_to] = mail[:reply_to].formatted.join(', ') if mail[:reply_to]
    payload[:bcc] = mail[:bcc].formatted.join(', ') if mail[:bcc]

    # Send the final payload to Mailjet Send API
    payload.merge(content)
    .merge(base_from)
    .merge(@delivery_method_options_v3_0)
    end
end

ActionMailer::Base.add_delivery_method :mailjet_api, Mailjet::APIMailer
