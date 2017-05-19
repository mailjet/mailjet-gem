module Mailjet
  class Graphstatistics
    include Mailjet::Resource
    self.resource_path = 'REST/graphstatistics'
    self.public_operations = [:get]
    self.filters = [:campaign_id, :campaign_status, :contact, :contacts_list, :custom_campaign, :from, :from_domain, :from_id, :from_ts, :from_type, :is_deleted, :is_newsletter_tool, :is_starred, :message_status, :period, :scale, :to_ts]
    self.resourceprop = [:blocked_count, :bounced_count, :clicked_count, :delivered_count, :opened_count, :processed_count, :queued_count, :ref_timestamp, :sendtime_start, :spamcomplaint_count, :unsubscribed_count]

    self.read_only = true

  end
end
