module Mailjet
  class Listrecipientstatistics
    include Mailjet::Resource
    self.resource_path = 'REST/listrecipientstatistics'
    self.public_operations = [:get]
    self.filters = [:blocked, :bounced, :click, :contact, :contacts_list, :is_active, :is_unsubscribed, :last_activity_at, :max_last_activity_at, :max_unsubscribed_at, :min_last_activity_at, :min_unsubscribed_at, :open, :queued, :sent, :show_extra_data, :spam, :unsubscribed]
    self.resourceprop = [:blocked_count, :bounced_count, :clicked_count, :data, :delivered_count, :last_activity_at, :list_recipient, :opened_count, :processed_count, :queued_count, :spam_complaint_count, :unsubscribed_count]

    self.read_only = true

  end
end
