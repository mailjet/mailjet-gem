module Mailjet
  class Widgetcustomvalue
    include Mailjet::Resource
    self.resource_path = 'REST/widgetcustomvalue'
    self.public_operations = [:get, :put, :post, :delete]
    self.filters = [:name, :widget]
    self.resourceprop = [:api_key, :display, :id, :name, :value, :widget]

  end
end
