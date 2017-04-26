module Mailjet
  class MessageDelivery
    include Mailjet::Resource
    self.resource_path = 'v3/send/message'
    self.public_operations = [:post]
    self.resourceprop = [:from, :sender, :to, :cc, :bcc, :subject, :text, :html, :attachment, :inline_attachments, :headers]
  end
end
