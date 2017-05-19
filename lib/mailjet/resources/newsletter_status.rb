module Mailjet
  class Newsletter_status
    include Mailjet::Resource
    self.action = 'status'
    self.resource_path = "REST/newsletter/id/#{self.action}"
    self.public_operations =  [:get]
    self.filters = []
    self.resourceprop = []

  end
end
