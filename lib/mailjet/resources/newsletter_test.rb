module Mailjet
  class Newsletter_test
    include Mailjet::Resource
    self.action = "test"
    self.resource_path = "REST/newsletter/id/#{self.action}"
    self.public_operations = [:post]
    self.filters = []
    self.resourceprop = [:email, :name]
    self.supported_versions = ['v3']
  end
end
