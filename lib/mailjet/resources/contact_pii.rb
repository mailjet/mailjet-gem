module Mailjet
  class ContactPii
    include Mailjet::Resource
    self.version = 'v4'
    self.resource_path = 'contacts'
    self.public_operations = [:delete]
  end
end
