require 'mailjet/resource'

module Mailjet
  class Contactslist_addcontact
    include Mailjet::Resource
    self.action = "addcontact"
    self.resource_path = "v3/REST/contactslist/id/#{self.action}"
    self.public_operations = [:post]
    self.filters = []
    self.properties = [:email, :name, :action, :properties]
  end
end
