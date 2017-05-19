module Mailjet
  class Metasender
    include Mailjet::Resource
    self.resource_path = 'REST/metasender'
    self.public_operations = [:get, :put, :post]
    self.filters = [:dns, :user]
    self.resourceprop = [:created_at, :description, :email, :filename, :id, :is_enabled]

  end
end
