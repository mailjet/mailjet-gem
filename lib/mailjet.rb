require 'active_support'

if defined?(ActionMailer)
  require 'action_mailer/version'
  require 'mailjet/mailer' if 3 == ActionMailer::VERSION::MAJOR
end

require 'delayed/railtie' if defined?(Rails::Railtie)
