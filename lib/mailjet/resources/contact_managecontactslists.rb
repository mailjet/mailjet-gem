module Mailjet
  class Contact_managecontactslists
    include Mailjet::Resource
    self.action = "managecontactslists"
    self.resource_path = "REST/contact/id/#{self.action}"
    self.public_operations = [:post]
    self.filters = []
    self.resourceprop = [:contacts_lists, 'ListID', :list_id, :action] #need 'ListID' and :action in a subpacket
  end
end
