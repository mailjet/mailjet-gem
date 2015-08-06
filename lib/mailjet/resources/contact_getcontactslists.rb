require 'mailjet/resource'

module Mailjet
  class Contact_getcontactslists
    include Mailjet::Resource
    self.action = "getcontactslists"
    self.resource_path = "v3/REST/contact/id/#{self.action}"
    self.public_operations = [:get]
    self.filters = []
    self.properties = []
  end
end
