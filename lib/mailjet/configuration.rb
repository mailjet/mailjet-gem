require 'active_support/core_ext/module/attribute_accessors'

module Mailjet
  module Configuration
    mattr_accessor :api_key
    mattr_accessor :secret_key
    mattr_accessor :end_point
    mattr_accessor :default_from

    @@end_point = 'https://api.preprod.mailjet.com'
  end
end
