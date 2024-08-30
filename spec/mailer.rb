require 'action_mailer'
require 'mailjet'

Mailjet.configure do |config|
  config.api_key = ENV['MJ_APIKEY_PUBLIC']
  config.secret_key = ENV['MJ_APIKEY_PRIVATE']
  config.default_from = 'gbadi@mailjet.com'
end

ActionMailer::Base.raise_delivery_errors = true

ActionMailer::Base.delivery_method = :mailjet_api

class Mailer < ActionMailer::Base
  @var = 'Hello'

  def test_email
    mail(:to      => "gbadi@mailjet.com",
         :subject => "testing mail",
         :template_path => '/Users/guillaume/mailjet-gem/spec/mailer',
         :template_name => 'test_email.html.erb')
  end
end
