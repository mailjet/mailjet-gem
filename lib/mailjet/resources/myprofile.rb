require 'mailjet/resource'

module Mailjet
  class Myprofile
    include Mailjet::Resource
    self.resource_path = 'v3/REST/myprofile'
    self.public_operations = [:get, :put]
    self.filters = [:user]
    self.properties = [:address_city, :address_country, :address_postal_code, :address_street, :billing_email, :birthday_at, :company_name, :contact_phone, :estimated_volume, :features, :firstname, :id, :industry, :lastname, :user, :vat, :vat_number, :website]

  end
end
