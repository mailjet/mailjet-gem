module Mailjet
  class Send
    include Mailjet::Resource

    self.resource_path = 'send'
    self.public_operations = [:post]
    self.supported_versions = ['v3.1']
  end
end
