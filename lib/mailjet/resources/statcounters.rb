module Mailjet
  class Statcounters
    include Mailjet::Resource
    self.resource_path = 'REST/statcounters'
    self.public_operations = [:get]
    self.filters = [:source_id, :counter_resolution, :counter_source, :counter_timing]
    self.resourceprop = [
      :api_key_id,
      :event_click_delay,
      :event_clicked_count,
      :event_open_delay,
      :event_opened_count,
      :event_spam_count,
      :event_unsubscribed_count,
      :event_workflow_exited_count,
      :message_blocked_count,
      :message_clicked_count,
      :message_deferred_count,
      :message_hard_bounced_count,
      :message_opened_count,
      :message_queued_count,
      :message_sent_count,
      :message_soft_bounced_count,
      :message_spam_count,
      :message_unsubscribed_count,
      :message_work_flow_exited_count,
      :source_id,
      :timeslice,
      :total,
    ]
    self.read_only = true
  end
end
