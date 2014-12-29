require 'mailjet/resource'

module Mailjet
  class Newsletter_send
    include Mailjet::Resource
    self.action = "send"
    self.resource_path = "v3/REST/newsletter/id/#{self.action}"
    self.public_operations = [:post]
    self.filters = []
    self.properties = []
  end
end
