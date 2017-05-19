module Mailjet
  class Newsletterproperties
    include Mailjet::Resource
    self.resource_path = 'REST/newsletterproperties'
    self.public_operations = [:get, :put, :post, :delete]
    self.filters = [:news_letter]
    self.resourceprop = [:id, :name, :news_letter, :property_name, :selector, :value]

  end
end
