module Mailjet
  class Contactslist_managecontact
    include Mailjet::Resource
    self.action = "managecontact"
    self.resource_path = "REST/contactslist/id/#{self.action}"
    self.public_operations = [:post]
    self.filters = []
    self.resourceprop = [:email, :name, :action, :properties]
  end
end
