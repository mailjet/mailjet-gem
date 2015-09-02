require 'mailjet/resource'

module Mailjet
  class Newsletter_status
    include Mailjet::Resource
    self.resource_path = 'v3/REST/campaignoverview'
    self.public_operations =  [:get]
    self.filters = []
    self.properties = []

  end
end
