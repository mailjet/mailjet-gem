module Mailjet
  class Preferences
    include Mailjet::Resource
    self.resource_path = 'REST/preferences'
    self.public_operations = [:get, :put, :post, :delete]
    self.filters = [:user]
    self.resourceprop = [:id, :key, :user, :value]

  end
end
