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
  def initialize(options = {})
    @version = Mailjet.config.api_version

    @delivery_method_options_v3_0 = options.slice(
      :api_key, :secret_key,
      :recipients, :'mj-prio', :'mj-campaign', :'mj-deduplicatecampaign',
      :'mj-templatelanguage', :'mj-templateerrorreporting', :'mj-templateerrordeliver', :'mj-templateid',
      :'mj-trackopen', :'mj-trackclick',
      :'mj-customid', :'mj-eventpayload', :vars, :headers,
    )

    @delivery_method_options_v3_1 = options.slice(
      :api_key, :secret_key,
      :'Priority', :'CustomCampaign', :'DeduplicateCampaign',
      :'TemplateLanguage', :'TemplateErrorReporting', :'TemplateErrorDeliver', :'TemplateID',
      :'TrackOpens', :'TrackClicks',
      :'CustomID', :'EventPayload', :'Variables', :'Headers',
    )
  end

  def deliver!(mail, opts = {})
#    p mail.header.fields

    # make options accessible with either String or Symbol
    options = HashWithIndifferentAccess.new(opts)

    # use given version if exists
    @version = options['version'] if options['version']

    # set FROM from config unless set
    mail[:from] ||= Mailjet.config.default_from

    case @version
    when 'v3.1'
      Mailjet::Send.create({:Messages => [setContentV3_1(mail)]})
    when 'v3'
      Mailjet::Send.create(setContentV3_0(mail))
    else
      raise Mailjet::Error.new("Wrong API version, given: #{@version.inspect}")
    end
  end

  def setContentV3_1(mail)
    raise Mailjet::Error.new('No recipient set') unless mail[:to]

    content = {}

    [:Text, :HTML].each do |key|
      method = "#{key.downcase}_part"
      next if mail.send(method).blank?
      content["#{key}Part".to_sym] = mail.send(method).try(:decoded)
    end

    if mail.attachments.any?
      content[:Attachments] = []
      content[:InlineAttachments] = []

      mail.attachments.each do |attachment|
        mailjet_attachment = {
          'ContentType' => attachment.content_type.split(';')[0],
          'Filename' => attachment.filename,
          'Base64Content' => Base64.encode64(attachment.body.decoded)
        }

        if attachment.inline?
          mailjet_attachment['ContentId'] = attachment.content_id
          content[:InlineAttachments].push(mailjet_attachment)
        else
          content[:Attachments].push(mailjet_attachment)
        end
      end
    end

    # We do the next part in purpose to accept only custom header from the user,
    # but without accepting the mailjet related ones. The mailjet related ones
    # are stocked in another variable and directly added to the body
    if mail.header.fields.any?
      content[:Headers] = {}

      mail.header.fields.each do |header|
        next unless header.name =~ /^X-(?!\b(MJ|Mailjet)\b).*$/
        content[:headers][header.name] = header.value
      end
    end

    # Reply-To is not a property in Mailjet Send API
    # Passing it as an header if mail.reply_to

    if mail.reply_to
      if mail.reply_to.display_names.first
        content[:Headers]['Reply-To'] = {
          Email: mail[:reply_to].addresses.first,
          Name:  mail[:reply_to].display_names.first
        }
      else
        content[:Headers]['Reply-To'] = { Email: mail[:reply_to].addresses.first }
      end
    end

    content[:From] = { Email: mail[:from].addresses.first }

    if mail[:from].display_names.first
      content[:From][:Name] = mail[:from].display_names.first
    end

    [:to, :cc, :bcc].each do |key|
      if mail[key]
        if mail[key].is_a? String
          content[key.capitalize] =
            if mail[key].display_name.first
              [{ Email: mail[key].address.first, Name: mail[key].display_name.first }]
            else
              [{ Email: mail[key].address.first }]
            end
        else
          content[key.capitalize] = mail[key].addrs.map do |cc|
            { Email: cc.address, Name: cc.display_name }
          end
        end
      end
    end

    content[:Subject] = mail.subject unless mail.subject.blank?
    content[:Sender] = mail[:sender] unless mail[:sender].blank?

    content.merge(@delivery_method_options_v3_1)
  end

  def setContentV3_0(mail)
    raise Mailjet::Error.new('No recipient set') unless mail[:to]

    content = {}

    [:text_part, :html_part].each do |key|
      mail.send(key).blank? || content[key] = mail.send(key).try(:decoded)
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

    # We do the next part in purpose to accept only custom header from the user,
    # but without accepting the mailjet related ones. The mailjet related ones
    # are stocked in another variable and directly added to the body
    if mail.header && !mail.header.fields.empty?
      content[:headers] = {}

      mail.header.fields.each do |header|
        next unless header.name =~ /^X-(?!\b(MJ|Mailjet)\b).*$/
        content[:headers][header.name] = header.value
      end
    end

    # Reply-To is not a property in Mailjet Send API
    # Passing it as an header
    content[:headers]['Reply-To'] = mail.reply_to.join(', ') if mail.reply_to

    # Mailjet Send API does not support full from. Splitting the from field into
    # two: name and email address
    mail[:from] ||= Mailjet.config.default_from

    [:cc, :bcc, :reply_to].each do |key|
      mail[key] && content[key] = mail[key].formatted.join(', ')
    end

    # Send the final payload to Mailjet Send API
    content
    .merge({
      from_name:  mail[:from].display_names.first,
      from_email: mail[:from].addresses.first,
      to:         mail[:to].formatted.join(', '),
      sender:     mail[:sender],
      subject:    mail.subject
    })
    .merge(@delivery_method_options_v3_0)
  end
end

ActionMailer::Base.add_delivery_method :mailjet_api, Mailjet::APIMailer
