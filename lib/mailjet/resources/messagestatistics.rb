module Mailjet
  class Messagestatistics
    include Mailjet::Resource
    self.resource_path = 'REST/messagestatistics'
    self.public_operations = [:get]
    self.filters = [:campaign_id, :campaign_status, :contact_email, :contact_id, :custom_campaign, :from, :from_domain, :from_id, :from_ts, :from_type, :is_deleted, :is_newsletter_tool, :is_starred, :message_status, :period, :to_ts]
    self.resourceprop = [:average_click_delay, :average_clicked_count, :average_open_delay, :average_opened_count, :blocked_count, :bounced_count, :campaign_count, :clicked_count, :delivered_count, :opened_count, :processed_count, :queued_count, :spam_complaint_count, :transactional_count, :unsubscribed_count]

    self.read_only = true

  end
end
