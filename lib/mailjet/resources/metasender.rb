require 'mailjet/resource'

module Mailjet
  class Metasender
    include Mailjet::Resource
    self.resource_path = 'v3/REST/metasender'
    self.public_operations = [:get, :put, :post]
    self.filters = [:dns, :user]
    self.properties = [:created_at, :description, :email, :filename, :id, :is_enabled]

  end
end
