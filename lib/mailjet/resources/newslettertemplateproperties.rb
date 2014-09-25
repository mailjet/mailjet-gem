require 'mailjet/resource'

module Mailjet
  class Newslettertemplateproperties
    include Mailjet::Resource
    self.resource_path = 'v3/REST/newslettertemplateproperties'
    self.public_operations = [:get, :put, :post, :delete]
    self.filters = [:news_letter_template]
    self.properties = [:id, :name, :property_name, :selector, :template, :value]

  end
end
