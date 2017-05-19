module Mailjet
  class Aggregategraphstatistics
    include Mailjet::Resource
    self.resource_path = 'REST/aggregategraphstatistics'
    self.public_operations =  [:get]
    self.filters = [:campaign_aggregate_id, :range]
    self.resourceprop = [:blocked_count, :blocked_std_dev, :bounced_count, :bounced_std_dev, :campaign_aggregate_id, :clicked_count, :clicked_std_dev, :opened_count, :open_std_dev, :ref_time_stamp, :sent_count, :sent_std_dev, :spam_complaint_count, :spam_complaint_std_dev, :unsubscribe_count, :unsubscribe_std_dev]

  end
end
