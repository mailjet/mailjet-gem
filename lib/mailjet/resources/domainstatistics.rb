module Mailjet
  class Domainstatistics
    include Mailjet::Resource
    self.resource_path = 'REST/domainstatistics'
    self.public_operations = [:get]
    self.filters = [:campaign_id, :campaign_status, :contacts_list, :custom_campaign, :from, :from_domain, :from_id, :from_ts, :from_type, :is_deleted, :is_newsletter_tool, :is_starred, :message_status, :period, :to_ts]
    self.resourceprop = [:blocked_count, :bounced_count, :clicked_count, :delivered_count, :domain, :id, :opened_count, :processed_count, :queued_count, :spam_complaint_count, :unsubscribed_count]

    self.read_only = true

  end
end
