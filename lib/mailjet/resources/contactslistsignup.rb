module Mailjet
  class Contactslistsignup
    include Mailjet::Resource
    self.resource_path = 'REST/contactslistsignup'
    self.public_operations = [:get]
    self.filters = [:api_key, :contact, :contacts_list, :domain, :email, :local_part, :max_confirm_at, :max_signup_at, :min_confirm_at, :min_signup_at, :source, :source_id]
    self.resourceprop = [:confirm_at, :confirm_ip, :contact, :email, :id, :list, :recipient, :signup_at, :signup_ip, :signup_key, :source, :source_id]

  end
end
