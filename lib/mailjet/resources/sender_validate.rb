
require 'mailjet/resource'

module Mailjet
  class Sender_validate
    include Mailjet::Resource
    self.action = "validate"
    self.resource_path = "v3/REST/sender/id/#{self.action}"
    self.public_operations = [:post]
    self.filters = []
    self.resourceprop = []
  end
end
