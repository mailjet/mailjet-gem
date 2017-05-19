module Mailjet
  class Campaignstatistics
    include Mailjet::Resource
    self.resource_path = 'REST/campaignstatistics'
    self.public_operations = [:get]
    self.filters = [:blocked, :bounced, :campaign_status, :click, :contacts_list, :from_type, :is_deleted, :is_starred, :last_activity_at, :max_last_activity_at, :min_last_activity_at, :news_letter, :open, :queued, :sender, :sent, :spam, :subject, :unsubscribed]
    self.resourceprop = [:blocked_count, :bounced_count, :campaign, :clicked_count, :delivered_count, :last_activity_at, :news_letter, :opened_count, :processed_count, :queued_count, :spam_complaint_count, :unsubscribed_count]

    self.read_only = true

  end
end
