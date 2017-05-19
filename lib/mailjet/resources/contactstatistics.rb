module Mailjet
  class Contactstatistics
    include Mailjet::Resource
    self.resource_path = 'REST/contactstatistics'
    self.public_operations = [:get]
    self.filters = [:blocked, :bounced, :click, :last_activity_at, :max_last_activity_at, :min_last_activity_at, :open, :queued, :sent, :spam, :unsubscribed]
    self.resourceprop = [:blocked_count, :bounced_count, :clicked_count, :contact, :delivered_count, :last_activity_at, :opened_count, :processed_count, :queued_count, :spam_complaint_count, :unsubscribed_count]

    self.read_only = true

  end
end
