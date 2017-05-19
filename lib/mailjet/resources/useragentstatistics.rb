module Mailjet
  class Useragentstatistics
    include Mailjet::Resource
    self.resource_path = 'REST/useragentstatistics'
    self.public_operations = [:get]
    self.filters = [:campaign_id, :campaign_status, :contacts_list, :custom_campaign, :event, :exclude_platform, :from, :from_domain, :from_id, :from_ts, :from_type, :is_deleted, :is_newsletter_tool, :is_starred, :period, :platform, :to_ts]
    self.resourceprop = [:count, :distinct_count, :platform, :user_agent]

    self.read_only = true

  end
end
