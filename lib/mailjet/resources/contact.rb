module Mailjet
  class Contact
    include Mailjet::Resource
    self.resource_path = 'REST/contact'
    self.public_operations = [:get, :put, :post]
    self.filters = [:campaign, :contacts_list, :is_unsubscribed, :last_activity_at, :recipient, :status]
    self.resourceprop = [
      :delivered_count,
      :email,
      :id,
      :is_opt_in_pending,
      :is_spam_complaining,
      :name,
      :unsubscribed_by,
      :is_excluded_from_campaigns
    ]
    self.read_only_attributes = [:created_at, :last_activity_at, :last_update_at, :unsubscribed_at]
  end
end
