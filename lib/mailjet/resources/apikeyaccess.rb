module Mailjet
  class Apikeyaccess
    include Mailjet::Resource
    self.resource_path = 'REST/apikeyaccess'
    self.public_operations = [:get, :put, :post, :delete]
    self.filters = [:api_key, :is_active, :real_user, :sub_account, :token, :user]
    self.resourceprop = [:allowed_access, :api_key, :created_at, :custom_name, :id, :is_active, :last_activity_at, :real_user, :subaccount, :user]

  end
end
