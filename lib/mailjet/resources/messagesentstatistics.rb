module Mailjet
  class Messagesentstatistics
    include Mailjet::Resource
    self.resource_path = 'REST/messagesentstatistics'
    self.public_operations = [:get]
    self.filters = [:all_messages, :campaign_id, :campaign_status, :contact, :contacts_list, :custom_campaign, :from, :from_domain, :from_id, :from_ts, :from_type, :is_deleted, :is_newsletter_tool, :is_starred, :message_status, :period, :to_ts]
    self.resourceprop = [:arrival_ts, :blocked, :bounce, :campaign, :click, :cnt_recipients, :contact, :message_id, :open, :queued, :sent, :spam, :state, :state_permanent, :status]

    self.read_only = true

  end
end
