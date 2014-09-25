require 'mailjet/resource'

module Mailjet
  class Apikeytotals
    include Mailjet::Resource
    self.resource_path = 'v3/REST/apikeytotals'
    self.public_operations = [:get]
    self.filters = []
    self.properties = [:blocked_count, :bounced_count, :clicked_count, :delivered_count, :last_activity, :opened_count, :processed_count, :queued_count, :spamcomplaint_count, :unsubscribed_count]

    self.read_only = true

  end
end
