module Mailjet
  class Send
    include Mailjet::Resource
#    self.version = 'v3.1'
    self.resource_path = 'send'
    self.public_operations = [:post]
  end
end
