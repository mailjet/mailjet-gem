module Mailjet
  class Contactslist
    include Mailjet::Resource
    self.resource_path = 'REST/contactslist'
    self.public_operations = [:get, :put, :post, :delete]
    self.filters = [:address, :exclude_id, :is_deleted, :name]
    self.resourceprop = [:address, :created_at, :id, :is_deleted, :name, :subscriber_count]

  end
end
