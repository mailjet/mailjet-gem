require 'mailjet/resource'

module Mailjet
  class Messagehistory
    include Mailjet::Resource
    self.resource_path = 'v3/REST/messagehistory'
    self.public_operations = [:get]
    self.filters = [:message]
    self.properties = [:event_at, :event_type, :useragent]

    self.read_only = true

  end
end
