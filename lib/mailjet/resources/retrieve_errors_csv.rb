module Mailjet
  class RetrieveErrosCsv
    include Mailjet::Resource
    self.action = "DATA/BatchJob"
    self.resource_path = "#{self.action}/id/CSVError/text:csv"
    self.public_operations = [:get]
  end
end