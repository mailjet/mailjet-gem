require 'mailjet/resource'

module Mailjet
  class Sender
    include Mailjet::Resource
    self.resource_path = 'v3/REST/sender'
    self.public_operations = [:get, :put, :post, :delete]
    self.filters = [:confirm_key, :domain, :email, :local_part, :show_deleted, :status]
    self.properties = [:confirm_key, :created_at, :dns, :email, :email_type, :filename, :id, :is_default_sender, :name, :status]

  end
end
