module Mailjet
  class Contactslist_managemanycontacts
    include Mailjet::Resource
    self.action = "managemanycontacts"
    self.resource_path = "REST/contactslist/id/#{self.action}"
    self.public_operations = [:post, :get] #GET is for when job_id is there
    self.filters = []
    self.resourceprop = [:action, :contacts, :email, :name, :properties]
  end
end
