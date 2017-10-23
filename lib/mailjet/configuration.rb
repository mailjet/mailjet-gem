require 'active_support/core_ext/module/attribute_accessors'

module Mailjet
  module Configuration
    mattr_accessor :api_key, :secret_key, :default_from

    DEFAULT = {
      api_version: 'v3',
      sandbox_mode: false,
      end_point: 'https://api.mailjet.com',
      perform_api_call: true,
    }

    DEFAULT.each do |param, default_value|
      mattr_accessor param
      self.send("#{param}=", default_value)
    end
  end
end
