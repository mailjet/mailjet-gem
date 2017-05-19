module Mailjet
  class Parseroute
    include Mailjet::Resource
    self.resource_path = 'REST/parseroute'
    self.public_operations = [:get, :put, :post, :delete]
    self.filters = [:api_key]
    self.resourceprop = [:api_key, :email, :id, :url]

  end
end
