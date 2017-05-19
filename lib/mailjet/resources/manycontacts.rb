module Mailjet
  class Manycontacts
    include Mailjet::Resource
    self.resource_path = 'REST/manycontacts'
    self.public_operations = [:post]
    self.filters = []
    self.resourceprop = [:action, :addresses, :errors, :force, :list_id, :recipients]

  end
end
