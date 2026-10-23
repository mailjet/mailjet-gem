module Mailjet
  class Statistics_recipient_esp
    include Mailjet::Resource
    self.resource_path = 'REST/statistics/recipient-esp'
    self.public_operations = [:get]
    self.filters = [:campaign_id, :esp_name]
    self.resourceprop = [
      :attempted_messages_count,
      :click_through_rate,
      :clicked_messages_count,
      :deferred_messages_count,
      :deferred_rate,
      :delivered_messages_count,
      :esp_name,
      :hard_bounced_messages_count,
      :hard_bounced_rate,
      :open_rate,
      :opened_messages_count,
      :soft_bounced_messages_count,
      :soft_bounced_rate,
      :spam_reports_count,
      :spam_reports_rate,
      :unsubscribed_messages_count,
      :unsubscribed_rate,
    ]

    self.read_only = true

  end
end
