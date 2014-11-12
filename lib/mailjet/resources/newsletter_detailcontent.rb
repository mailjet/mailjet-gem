require 'mailjet/resource'

module Mailjet
  class Newsletter_detailcontent
    include Mailjet::Resource
    self.action = "detailcontent"
    self.resource_path = "v3/REST/newsletter/id/#{self.action}"
    self.public_operations = [:get, :put, :post, :delete]
    self.filters = []
    self.properties = ["Text-part", "Html-part"]

  end
end
