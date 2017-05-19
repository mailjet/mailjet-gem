module Mailjet
  class MessageDelivery
    include Mailjet::Resource
#    self.version = 'v3.1/'
    self.resource_path = 'send/message'
    self.public_operations = [:post]
    self.resourceprop = [:from, :sender, :to, :cc, :bcc, :subject, :text, :html, :attachment, :inline_attachments, :headers]
  end
end
