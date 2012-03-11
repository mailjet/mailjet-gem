require 'active_support/core_ext/module/attribute_accessors'

module Mailjet
  module Configuration
    mattr_accessor :api_version
    mattr_accessor :api_key
    mattr_accessor :secret_key
    mattr_accessor :use_https
    mattr_accessor :domain
    
    @@use_https = true
    @@api_version = 0.1
    @@domain = ''
  end
end