require 'mailjet/resource'

module Mailjet
  class Contactslist
    include Mailjet::Resource
    self.resource_path = 'v3/REST/contactslist'
    self.public_operations = [:get, :put, :post, :delete]
    self.filters = [:address, :exclude_id, :is_deleted, :name]
    self.properties = [:address, :created_at, :id, :is_deleted, :name, :subscriber_count]

  end
end
