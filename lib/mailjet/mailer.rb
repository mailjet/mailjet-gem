require 'action_mailer'
require 'mail'

class Mailjet::Mailer < ::Mail::SMTP
  def initialize options = {}
    super({
      :address  => "in.mailjet.com",
      :port  => 587,
      :authentication  => 'plain',
      :user_name => Mailjet.config.api_key,
      :password  => Mailjet.config.secret_key,
      :domain => Mailjet.config.domain,
      :enable_starttls_auto => true
    }.merge(options))
  end
end

ActionMailer::Base.add_delivery_method :mailjet, Mailjet::Mailer
