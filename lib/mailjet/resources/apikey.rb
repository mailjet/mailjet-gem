module Mailjet
  class Apikey
    include Mailjet::Resource
    self.resource_path = 'REST/apikey'
    self.public_operations = [:get, :put, :post, :delete]
    self.filters = [:api_key, :confirm_key, :custom_status, :is_active, :is_master, :key_type, :name, :user]
    self.resourceprop = [:api_key, :created_at, :custom_status, :id, :inactive_reason, :is_active, :is_master, :name, :runlevel, :secret_key, :track_host, :user_id]

  end
end
