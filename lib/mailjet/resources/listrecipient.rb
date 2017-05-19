module Mailjet
  class Listrecipient
    include Mailjet::Resource
    self.resource_path = 'REST/listrecipient'
    self.public_operations = [:get, :put, :post, :delete]
    self.filters = [:active, :blocked, :contact, :contact_email, :contacts_list, :last_activity_at, :list_name, :opened, :status, :unsub]
    self.resourceprop = [:contact, :id, :is_active, :is_unsubscribed, :list, :unsubscribed_at, :contact_id, :list_id, 'ContactID', 'ListID', 'ContactALT', 'ListALT']

  end
end
