require 'active_support'
require 'ostruct'
require 'mailjet/core_extensions/ostruct'
require 'mailjet/configuration'
require 'mailjet/api_error'

require 'mailjet/resource'
require 'mailjet/message_delivery'

Dir[File.expand_path("../mailjet/resources/*.rb", __FILE__)].each do |file|
  require file
end

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
  require 'mailjet/mailer' if ActionMailer::Base.respond_to?(:add_delivery_method)
end

require 'mailjet/rack/endpoint'
