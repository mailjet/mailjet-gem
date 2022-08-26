module Mailjet
  class Contact
    include Mailjet::Resource
    self.resource_path = 'REST/contact'
    self.public_operations = [:get, :put, :post]
    self.filters = [:campaign, :contacts_list, :is_unsubscribed, :last_activity_at, :recipient, :status]
    self.resourceprop = [:created_at, :delivered_count, :email, :id, :is_opt_in_pending, :is_spam_complaining, :last_activity_at, :last_update_at, :name, :unsubscribed_at, :unsubscribed_by]

  end
end
