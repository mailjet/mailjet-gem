# encoding: utf-8
require "json"

module Mailjet
  class ApiError < StandardError

    attr_accessor :code, :reason

    # @param code [Integer] HTTP response status code
    # @param body [String] JSON response body
    # @param request [Object] any request object
    # @param url [String] request URL
    # @param params [Hash] request headers and parameters
    def initialize(code, body, request, url, params)
      self.code = code
      self.reason = ""
      begin
        resdec = JSON.parse(body)
        self.reason = resdec['ErrorMessage']
      rescue JSON::ParserError
        self.reason = body
      end

      message = "error #{code} while sending #{request.inspect} to #{url} with #{params.inspect}"
      error_details = body.inspect
      hint = "Please see https://dev.mailjet.com/guides/#status-codes for more informations on error numbers."

      super("#{message}\n\n#{error_details}\n\n#{hint}\n\n")
    end
  end
end


