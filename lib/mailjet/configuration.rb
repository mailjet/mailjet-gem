module Mailjet
  module Configuration
    def self.api_key
      @api_key
    end

    def self.api_key=(api_key)
      @api_key = api_key
    end

    def self.secret_key
      @secret_key
    end

    def self.secret_key=(secret_key)
      @secret_key = secret_key
    end

    def self.default_from
      @default_from
    end

    def self.default_from=(default_from)
      @default_from = default_from
    end

    def self.api_version
      @api_version
    end

    def self.api_version=(api_version)
      @api_version = api_version
    end

    def self.sandbox_mode
      @sandbox_mode
    end

    def self.sandbox_mode=(sandbox_mode)
      @sandbox_mode = sandbox_mode
    end

    def self.end_point
      @end_point
    end

    def self.end_point=(end_point)
      @end_point = end_point
    end

    def self.perform_api_call
      @perform_api_call
    end

    def self.perform_api_call=(perform_api_call)
      @perform_api_call = perform_api_call
    end

    DEFAULT = {
      api_version: 'v3',
      sandbox_mode: false,
      end_point: 'https://api.mailjet.com',
      perform_api_call: true,
    }

    DEFAULT.each do |param, default_value|
      self.send("#{param}=", default_value)
    end
  end
end
