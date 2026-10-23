module Mailjet
  class Newsletter_send
    include Mailjet::Resource
    self.action = "send"
    self.resource_path = "REST/newsletter/id/#{self.action}"
    self.public_operations = [:post]
    self.replaced_by = 'Mailjet::Campaigndraft_send'
    self.filters = []
    self.resourceprop = []
  end
end
