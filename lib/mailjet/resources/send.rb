module Mailjet
  class Send
    include Mailjet::Resource

    self.resource_path = 'send'
    self.public_operations = [:post]
  end
end
