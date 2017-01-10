require 'active_support/core_ext/module/attribute_accessors'

module Mailjet
  module Configuration
    mattr_accessor :api_key
    mattr_accessor :secret_key
    mattr_accessor :end_point
    mattr_accessor :default_from
    mattr_accessor :uversion do
      'v3'
    end
    mattr_accessor :main_url do
      'https://api.mailjet.com'
    end
    mattr_accessor :is_called do
      true
    end

    # @@end_point = 'https://api.preprod.mailjet.com'
    # @@end_point = 'https://api.mailjet.com'

  end
end
