require 'mailjet/resource'

module Mailjet
  class Send
    include Mailjet::Resource
    self.resource_path = 'v3/send/'
    self.public_operations = [:post]
    self.properties = [:from_email, :from_name, :recipients, :subject, :text_part, :html_part, :attachments]
  end
end
