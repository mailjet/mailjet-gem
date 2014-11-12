require 'mailjet/resource'

module Mailjet
  class Newsletter_schedule
    include Mailjet::Resource
    self.action = "schedule"
    self.resource_path = "v3/REST/newsletter/id/#{self.action}"
    self.public_operations = [:post, :delete]
    self.filters = []
    self.properties = [:date]
    
  end
end
