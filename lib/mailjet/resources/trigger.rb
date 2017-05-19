module Mailjet
  class Trigger
    include Mailjet::Resource
    self.resource_path = 'REST/trigger'
    self.public_operations = [:get, :put, :post, :delete]
    self.filters = [:event, :min_added_ts]
    self.resourceprop = [:added_ts, :api_key, :details, :event, :id, :user]

  end
end
