module Mailjet
  class Send
    include Mailjet::Resource
    self.resource_path = 'v3/send/'
    self.public_operations = [:post]
  end
end
