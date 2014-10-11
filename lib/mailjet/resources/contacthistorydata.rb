require 'mailjet/resource'

module Mailjet
  class Contacthistorydata
    include Mailjet::Resource
    self.resource_path = 'v3/REST/contacthistorydata'
    self.public_operations = [:get, :post, :delete]
    self.filters = [:contact, :last, :max_created_at, :min_created_at, :name]
    self.properties = [:contact, :created_at, :data, :id, :name]

  end
end
