module Mailjet
  class Messageinformation
    include Mailjet::Resource
    self.resource_path = 'REST/messageinformation'
    self.public_operations = [:get]
    self.filters = [:campaign_id, :campaign_status, :contacts_list, :custom_campaign, :from, :from_domain, :from_id, :from_ts, :from_type, :is_deleted, :is_newsletter_tool, :is_starred, :message_status, :period, :to_ts]
    self.resourceprop = [:campaign, :click_tracked_count, :contact, :created_at, :id, :message_size, :open_tracked_count, :queued_count, :send_end_at, :sent_count, :spam_assassin_rules, :spam_assassin_score]

    self.read_only = true

  end
end
