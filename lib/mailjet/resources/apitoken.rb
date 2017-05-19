module Mailjet
  class Apitoken
    include Mailjet::Resource
    self.resource_path = 'REST/apitoken'
    self.public_operations = [:get, :put, :post, :delete]
    self.filters = [:api_key, :catched_ip, :is_active, :is_api_key_active, :token]
    self.resourceprop = [:allowed_access, :api_key, :catched_ip, :created_at, :first_used_at, :id, :is_active, :lang, :last_used_at, :sent_data, :timezone, :token, :token_type, :valid_for]

  end
end
