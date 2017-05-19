module Mailjet
  class Eventcallbackurl
    include Mailjet::Resource
    self.resource_path = 'REST/eventcallbackurl'
    self.public_operations = [:get, :put, :post, :delete]
    self.filters = [:api_key, :backup, :event_type, :status, :version]
    self.resourceprop = [:api_key, :event_type, :id, :is_backup, :status, :url, :version]

  end
end
