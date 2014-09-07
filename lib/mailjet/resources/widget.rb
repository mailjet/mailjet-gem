require 'mailjet/resource'

module Mailjet
  class Widget
    include Mailjet::Resource
    self.resource_path = 'v3/REST/widget'
    self.public_operations = [:get, :put, :post, :delete]
    self.filters = [:active, :api_key, :contacts_list, :locale, :message_template, :sender]
    self.properties = [:created_at, :from, :id, :is_active, :list, :locale, :name, :replyto, :sendername, :subject, :template]

  end
end
