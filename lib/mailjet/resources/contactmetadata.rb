module Mailjet
  class Contactmetadata
    include Mailjet::Resource
    self.resource_path = 'REST/contactmetadata'
    self.public_operations = [:get, :put, :post, :delete]
    self.filters = [:data_type, :namespace]
    self.resourceprop = [:datatype, :id, :name, :name_space]
    self.supported_versions = ['v3']
  end
end
