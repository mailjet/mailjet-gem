module Mailjet
  class DNS
    include Mailjet::Resource
    self.resource_path = 'REST/dns'
    self.public_operations = [:get]
    self.filters = []
    self.resourceprop = [:id, :isCheckInProgress, :DKIMStatus, :DKIMValue, :DKIMName, :format, :lastCheckedAt, :SPFStatus, :SPFValue, :ownershipToken]
    self.supported_versions = ['v3']
  end
end
