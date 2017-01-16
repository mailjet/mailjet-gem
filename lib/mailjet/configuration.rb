require 'active_support/core_ext/module/attribute_accessors'

module Mailjet
  module Configuration
    mattr_accessor :api_key
    mattr_accessor :secret_key
    mattr_accessor :end_point
    mattr_accessor :default_from
    mattr_accessor :api_version do
      'v3'
    end
    mattr_accessor :end_point do
      'https://api.mailjet.com'
    end
    mattr_accessor :perform_api_call do
      true
    end

  end
end
