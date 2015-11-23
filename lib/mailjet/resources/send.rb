require 'mailjet/resource'

module Mailjet
  class Send
    include Mailjet::Resource
    self.resource_path = 'v3/send/'
    self.public_operations = [:post]
    self.resourceprop = [:from_email, :from_name, :recipients, :subject, :text_part, :html_part, :attachments, :inline_attachments, 'mj-template-id', 'mj-custom-id']
  end
end
