module Mailjet
  class Statistics_linkclick
    include Mailjet::Resource
    self.resource_path = 'REST/statistics/link-click'
    self.public_operations = [:get]
    self.filters = [:campaign_id]
    self.resourceprop = [:url, :position_index, :clicked_messages_count, :clicked_events_count]

    self.read_only = true

  end
end
