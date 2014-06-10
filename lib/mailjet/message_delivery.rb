require 'mailjet/resource'

module Mailjet
  class MessageDelivery
    include Mailjet::Resource
    self.resource_path = 'v3/send'
    self.public_operations = [:post]
  end
end
