require 'active_support'
require 'mailjet/api'
require 'mailjet/api_request'
require 'mailjet/api_error'
require 'mailjet/configuration'

module Mailjet
  def self.configure
    yield Mailjet::Configuration
  end

  def self.config
    Mailjet::Configuration
  end
end

if defined?(ActionMailer)
  require 'action_mailer/version'
  require 'mailjet/mailer' if 3 == ActionMailer::VERSION::MAJOR
end
require 'mailjet/railtie' if defined?(Rails::Railtie)

require 'mailjet/rack/endpoint'