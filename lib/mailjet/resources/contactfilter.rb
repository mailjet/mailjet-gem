module Mailjet
  class Contactfilter
    include Mailjet::Resource
    self.resource_path = 'REST/contactfilter'
    self.public_operations = [:get, :put, :post, :delete]
    self.filters = [:show_deleted, :status]
    self.resourceprop = [:description, :expression, :id, :name, :status]

  end
end
