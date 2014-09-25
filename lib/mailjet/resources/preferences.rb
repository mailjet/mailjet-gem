require 'mailjet/resource'

module Mailjet
  class Preferences
    include Mailjet::Resource
    self.resource_path = 'v3/REST/preferences'
    self.public_operations = [:get, :put, :post, :delete]
    self.filters = [:user]
    self.properties = [:id, :key, :user, :value]

  end
end
