require 'mailjet/resource'

module Mailjet
  class Contactslist_managemanycontacts
    include Mailjet::Resource
    self.action = "managemanycontacts"
    self.resource_path = "v3/REST/contactslist/id/#{self.action}"
    self.public_operations = [:post, :get]
    self.filters = []
    self.properties = [:action, :contacts, :email, :name, :properties]
  end
end
