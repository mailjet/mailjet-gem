require 'json/ext'
require 'yajl'
require 'mailjet/configuration'

require 'mailjet/resource'
require 'mailjet/message_delivery'

Dir[File.expand_path("../mailjet/{resources,exception}/*.rb", __FILE__)].each do |file|
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

ActiveSupport.on_load(:action_mailer) do
  require 'action_mailer/version'
  require 'mailjet/mailer' if ActionMailer::Base.respond_to?(:add_delivery_method)
end

require 'mailjet/rack/endpoint'
