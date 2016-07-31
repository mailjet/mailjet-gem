require 'action_mailer'
require 'mail'

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
    require 'byebug'
    byebug
    if mail.multipart?
      content = {
        :text => mail.text_part.try(:decoded),
        :html => mail.html_part.try(:decoded),
        :attachment => mail.attachments.select{ |a| !a.inline? }.try(:decoded),
        :inlineattachment => mail.attachments.select{ |a| !a.inline? }.try(:decoded)
      }
    else
      content = (mail.mime_type == "text/html") ? {:html_part => mail.body.raw_source} : {:text_part => mail.body.raw_source}
    end

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
    :cc => mail.cc,
    :bcc => mail.bcc,
    :subject => mail.subject,
    :'mj-customid' => mail['X-MJ-CustomID'] && mail['X-MJ-CustomID'].value,
    :'mj-eventpayload' => mail['X-MJ-EventPayload'] && mail['X-MJ-EventPayload'].value
	}.merge(content).merge(base_from).merge(@delivery_method_options)

	Mailjet::Send.create(payload)

	end
end

ActionMailer::Base.add_delivery_method :mailjet_api, Mailjet::APIMailer
