require 'mailjet/resource'

module Mailjet
  class Senderstatistics
    include Mailjet::Resource
    self.resource_path = 'v3/REST/senderstatistics'
    self.public_operations = [:get]
    self.filters = [:domain, :email, :sender]
    self.properties = [:blocked_count, :bounced_count, :clicked_count, :delivered_count, :last_activity_at, :opened_count, :processed_count, :queued_count, :sender, :spam_complaint_count, :unsubscribed_count]

    self.read_only = true

  end
end
