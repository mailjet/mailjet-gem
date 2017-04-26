module Mailjet
  class DNS
    include Mailjet::Resource
    self.resource_path = 'v3/REST/dns'
    self.public_operations = [:get]
    self.filters = []
    self.resourceprop = [:id, :isCheckInProgress, :DKIMStatus, :DKIMValue, :DKIMName, :format, :lastCheckedAt, :SPFStatus, :SPFValue, :ownershipToken]

  end
end
