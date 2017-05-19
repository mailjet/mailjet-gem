module Mailjet
  class DNS_check
    include Mailjet::Resource
    self.action = "check"
    self.resource_path = "REST/dns/id/#{self.action}"
    self.public_operations = [:post]
    self.filters = []
    self.resourceprop = []

  end
end
