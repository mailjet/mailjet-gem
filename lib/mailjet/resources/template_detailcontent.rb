module Mailjet
  class Template_detailcontent
    include Mailjet::Resource
    self.action = 'detailcontent'
    self.resource_path = "REST/template/id/#{self.action}"
    self.public_operations = [:get,:post]
    self.filters = []
    self.resourceprop = [:text_part, :html_part, :headers, :mjml_content]

  end
end
