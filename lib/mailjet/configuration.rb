require 'active_support/core_ext/module/attribute_accessors'

module Mailjet
  module Configuration
    mattr_accessor :api_version
    mattr_accessor :api_key
    mattr_accessor :secret_key
    mattr_accessor :use_https
    mattr_accessor :domain
    mattr_accessor :default_from
    
    @@use_https = true
    @@api_version = 0.1
    @@domain = ''
  end
end