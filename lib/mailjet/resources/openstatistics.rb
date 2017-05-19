module Mailjet
  class Openstatistics
    include Mailjet::Resource
    self.resource_path = 'REST/openstatistics'
    self.public_operations = [:get]
    self.filters = [:campaign_id, :campaign_status, :contacts_list, :custom_campaign, :from, :from_domain, :from_id, :from_ts, :from_type, :is_deleted, :is_newsletter_tool, :is_starred, :message_status, :period, :to_ts]
    self.resourceprop = [:opened_count, :opened_delay, :processed_count]

    self.read_only = true

  end
end
