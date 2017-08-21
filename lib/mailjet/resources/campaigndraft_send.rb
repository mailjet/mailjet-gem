module Mailjet
  class Campaigndraft_send
    include Mailjet::Resource
    self.action = "send"
    self.resource_path = "REST/campaigndraft/id/#{self.action}"
    self.public_operations = [:post]
    self.filters = []
    self.resourceprop = []
  end
end
