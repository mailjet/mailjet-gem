require 'mailjet/resource'

module Mailjet
  class Contactmetadata
    include Mailjet::Resource
    self.resource_path = 'v3/REST/contactmetadata'
    self.public_operations = [:get, :put, :post, :delete]
    self.filters = [:data_type, :namespace]
    self.properties = [:datatype, :id, :name, :name_space]

  end
end
