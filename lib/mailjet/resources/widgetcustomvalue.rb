require 'mailjet/resource'

module Mailjet
  class Widgetcustomvalue
    include Mailjet::Resource
    self.resource_path = 'v3/REST/widgetcustomvalue'
    self.public_operations = [:get, :put, :post, :delete]
    self.filters = [:name, :widget]
    self.properties = [:api_key, :display, :id, :name, :value, :widget]

  end
end
