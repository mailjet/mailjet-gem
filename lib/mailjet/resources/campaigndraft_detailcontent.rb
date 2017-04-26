module Mailjet
  class Campaigndraft_detailcontent
    include Mailjet::Resource
    self.action = "detailcontent"
    self.resource_path = "v3/REST/campaigndraft/id/#{self.action}"
    self.public_operations = [:get, :post]
    self.filters = []
    self.resourceprop = [:text_part, :html_part, :headers, :mjml_content]

  end
end
