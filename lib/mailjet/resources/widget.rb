module Mailjet
  class Widget
    include Mailjet::Resource
    self.resource_path = 'REST/widget'
    self.public_operations = [:get, :put, :post, :delete]
    self.filters = [:active, :api_key, :contacts_list, :locale, :message_template, :sender]
    self.resourceprop = [:created_at, :from, :id, :is_active, :list, :locale, :name, :replyto, :sendername, :subject, :template]

  end
end
