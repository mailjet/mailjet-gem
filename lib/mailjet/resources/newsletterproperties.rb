require 'mailjet/resource'

module Mailjet
  class Newsletterproperties
    include Mailjet::Resource
    self.resource_path = 'v3/REST/newsletterproperties'
    self.public_operations = [:get, :put, :post, :delete]
    self.filters = [:news_letter]
    self.properties = [:id, :name, :news_letter, :property_name, :selector, :value]

  end
end
