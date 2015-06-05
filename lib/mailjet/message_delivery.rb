require 'mailjet/resource'

module Mailjet
  class MessageDelivery
    include Mailjet::Resource
    self.resource_path = 'v3/send/message'
    self.public_operations = [:post]
    self.properties = [:from, :sender, :to, :cc, :bcc, :subject, :text, :html, :attachment, :inlineattachment, :header, :'mj-customid', :'mj-eventpayload', :'mj-trackclick']
  end
end
