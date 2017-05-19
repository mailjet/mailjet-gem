module Mailjet
  class Messagehistory
    include Mailjet::Resource
    self.resource_path = 'REST/messagehistory'
    self.public_operations = [:get]
    self.filters = [:message]
    self.resourceprop = [:event_at, :event_type, :useragent]

    self.read_only = true

  end
end
