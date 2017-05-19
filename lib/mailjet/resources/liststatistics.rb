module Mailjet
  class Liststatistics
    include Mailjet::Resource
    self.resource_path = 'REST/liststatistics'
    self.public_operations = [:get]
    self.filters = [:address, :calc_active_unsub, :exclude_id, :is_deleted, :name]
    self.resourceprop = [:active_count, :active_unsubscribed_count, :address, :blocked_count, :bounced_count, :clicked_count, :created_at, :delivered_count, :id, :is_deleted, :last_activity_at, :name, :opened_count, :spam_complaint_count, :subscriber_count, :unsubscribed_count]

    self.read_only = true

  end
end
