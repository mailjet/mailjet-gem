require 'mailjet/resource'

module Mailjet
  class Contact_managemanycontacts
    include Mailjet::Resource
    self.action = "managemanycontacts"
    #might be different
    self.resource_path = "v3/REST/contact/#{self.action}"
    self.public_operations = [:post, :get]
    self.filters = []
    self.properties = [:contact_lists, :contacts] #need 'ListID' and :action in a subpacket
  end
end
