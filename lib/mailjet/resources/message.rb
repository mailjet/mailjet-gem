module Mailjet
  class Message
    include Mailjet::Resource
    self.resource_path = 'REST/message'
    self.public_operations = [:get]
    self.filters = [:campaign, :contact, :destination, :message_state, :plan_subscription, :sender]
    self.resourceprop = [:arrived_at, :attachment_count, :attempt_count, :campaign, :contact, :delay, :destination, :filter_time, :from, :id, :is_click_tracked, :is_html_part_included, :is_open_tracked, :is_text_part_included, :is_unsub_tracked, :message_size, :spamassassin_score, :spamass_rules, :state, :state_permanent, :status]

  end
end
