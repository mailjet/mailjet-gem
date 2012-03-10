# encoding: utf-8

module Mailjet
  class ApiError < StandardError
    def initialize(code)
      super("Error #{code} see http://api.mailjet.com/#{Mailjet.config.api_version}/doc/general/errors.html")
    end
  end
end