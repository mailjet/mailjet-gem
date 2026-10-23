module Mailjet
  class Newsletter_status
    include Mailjet::Resource
    self.action = 'status'
    self.resource_path = "REST/newsletter/id/#{self.action}"
    self.public_operations =  [:get]
    self.replaced_by = 'Mailjet::Campaigndraft_status'
    self.filters = []
    self.resourceprop = []

  end
end
