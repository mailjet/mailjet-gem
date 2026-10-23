module Mailjet
  class Newsletter_detailcontent
    include Mailjet::Resource
    self.action = "detailcontent"
    self.resource_path = "REST/newsletter/id/#{self.action}"
    self.public_operations = [:get, :post]
    self.replaced_by = 'Mailjet::Campaigndraft_detailcontent'
    self.filters = []
    self.resourceprop = [:text_part, :html_part, :headers, :mjml_content]

  end
end
