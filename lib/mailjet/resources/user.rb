require 'mailjet/resource'

module Mailjet
  class User
    include Mailjet::Resource
    self.resource_path = 'v3/REST/user'
    self.public_operations = [:get, :put]
    self.filters = [:is_activated, :new_email, :user_name]
    self.properties = [:created_at, :email, :id, :is_rules_accepted, :last_ip, :last_login_at, :locale, :max_allowed_api_keys, :timezone, :username, :warned_ratelimit_at]

  end
end
