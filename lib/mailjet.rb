require 'active_support'
require 'ostruct'
require 'mailjet/api'
require 'mailjet/api_request'
require 'mailjet/api_error'
require 'mailjet/configuration'
require 'mailjet/contact'
require 'mailjet/list'
require 'mailjet/campaign'
require 'mailjet/template_category'
require 'mailjet/template_model'
require 'mailjet/reporting'
require 'mailjet/click'
require 'mailjet/email'


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

require 'mailjet/rack/endpoint'