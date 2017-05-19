module Mailjet
  class Contactdata
    include Mailjet::Resource
    self.resource_path = 'REST/contactdata'
    self.public_operations = [:get, :put, :post, :delete]
    self.filters = [:campaign, :contacts_list, :fields, :is_unsubscribed, :last_activity_at, :recipient, :status]
    self.resourceprop = [:contact_id, :data, :id, 'ContactID', 'Name', 'Value']

  end
end
