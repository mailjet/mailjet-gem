module Mailjet
  class Openinformation
    include Mailjet::Resource
    self.resource_path = 'REST/openinformation'
    self.public_operations = [:get]
    self.filters = [:campaign_id, :campaign_status, :contacts_list, :custom_campaign, :from, :from_domain, :from_id, :from_ts, :from_type, :is_deleted, :is_newsletter_tool, :is_starred, :message_status, :period, :to_ts]
    self.resourceprop = [:arrived_at, :campaign, :contact, :id, :message_id, :opened_at, :user_agent, :user_agent_full]

    self.read_only = true

  end
end
