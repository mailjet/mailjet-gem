require 'active_support/core_ext/module/attribute_accessors'

module Mailjet
  module Configuration
    mattr_accessor :api_key
    mattr_accessor :secret_key
    mattr_accessor :end_point
    mattr_accessor :default_from
    mattr_accessor :path_to_crt

    Mailjet::Configuration.path_to_crt = ""
    if File.exists?(Mailjet::Configuration.path_to_crt)
      @@end_point = 'https://api.preprod.mailjet.com'
    else
      @@end_point = 'https://api.mailjet.com'
    end
    puts @@end_point
  end
end
