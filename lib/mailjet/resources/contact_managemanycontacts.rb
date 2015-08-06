require 'mailjet/resource'

module Mailjet
  class Contact_managemanycontacts
    include Mailjet::Resource
    self.action = "managemanycontacts"
    #might be different
    self.resource_path = "v3/REST/contact/#{self.action}"
    self.public_operations = [:post, :get] #GET is for job_id ammended at the end
    self.filters = []
    self.properties = [:contacts_lists, :contacts, :list_id, 'ListID', :action, :email, :name, :properties] #need 'ListID' and :action in a subpacket
  end
end
