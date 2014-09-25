require 'mailjet/resource'

module Mailjet
  class Messagestate
    include Mailjet::Resource
    self.resource_path = 'v3/REST/messagestate'
    self.public_operations = [:get]
    self.filters = []
    self.properties = [:id, :related_to, :state]

  end
end
