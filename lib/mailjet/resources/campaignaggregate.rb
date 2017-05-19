module Mailjet
  class Campaignaggregate
    include Mailjet::Resource
    self.resource_path = 'REST/campaignaggregate'
    self.public_operations =  [:get, :post, :put, :delete]
    self.filters = [:contact_filter, :contacts_list, :sender]
    self.resourceprop = [:campaign_ids, :contact_filter_id, :campaign_filter_alt, :contacts_list_id, :contacts_list_alt, :final, :form_date, :id, :keyword, :name, :sender_id, :sender_alt, :to_dat]

  end
end
