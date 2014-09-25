require 'mailjet/resource'

module Mailjet
  class Metadata
    include Mailjet::Resource
    self.resource_path = 'v3/REST/metadata'
    self.public_operations = [:get]
    self.filters = [:public_resources, :read_only_resources, :resource_name]
    self.properties = [:description, :filters, :is_read_only, :name, :private_operations, :properties, :public_operations, :sort_info, :unique_key]

    self.read_only = true

  end
end
