module Mailjet
  class ContactslistCsv
    include Mailjet::Resource
    self.action = "DATA/contactslist"
    self.resource_path = "#{self.action}/id/CSVData/text:plain"
    self.public_operations = [:post]
  end
end
