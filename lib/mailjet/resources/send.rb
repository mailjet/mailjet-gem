require 'mailjet/resource'

module Mailjet
  class Send
    include Mailjet::Resource
    self.resource_path = 'v3/send/'
    self.public_operations = [:post]
    self.resourceprop = [:from_email, :from_name, :recipients, :subject, :vars, :text_part, :html_part, :attachments, :inline_attachments, :headers, 'Mj-TemplateID', 'Mj-CustomID', :message_id, :messages, :to, :cc, :bcc, 'Mj-TemplateLanguage', 'MJ-TemplateErrorReporting', 'MJ-TemplateErrorDeliver']
  end
end
