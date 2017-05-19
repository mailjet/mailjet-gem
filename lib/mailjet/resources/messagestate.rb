module Mailjet
  class Messagestate
    include Mailjet::Resource
    self.resource_path = 'REST/messagestate'
    self.public_operations = [:get]
    self.filters = []
    self.resourceprop = [:id, :related_to, :state]

  end
end
