module Mailjet
  class Toplinkclicked
    include Mailjet::Resource
    self.resource_path = 'REST/toplinkclicked'
    self.public_operations = [:get]
    self.filters = [:campaign_id, :campaign_status, :contact, :contacts_list, :custom_campaign, :from, :from_domain, :from_id, :from_ts, :from_type, :is_deleted, :is_newsletter_tool, :is_starred, :message, :period, :to_ts]
    self.resourceprop = [:clicked_count, :id, :link_id, :url]

    self.read_only = true

  end
end
