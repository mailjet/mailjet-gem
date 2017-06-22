module Mailjet
  class Newsletter_schedule
    include Mailjet::Resource
    self.action = "schedule"
    self.resource_path = "REST/newsletter/id/#{self.action}"
    self.public_operations = [:get, :post, :delete]
    self.filters = []
    self.resourceprop = [:date]

  end
end
