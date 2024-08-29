require 'yajl'
require 'json'

module Mailjet
  class Error < StandardError
    attr_reader :object

    def initialize(message = nil, object = nil)
      super(message)
      @object = object
    end
  end

  class ApiError < StandardError
    attr_reader :code, :reason

    # @param code [Integer] HTTP response status code
    # @param body [String] JSON response body
    # @param request [Object] any request object
    # @param url [String] request URL
    # @param params [Hash] request headers and parameters
    def initialize(code, body, request, url, params)
      @code = code
      @reason = begin
        resdec = JSON.parse(body)
        resdec['ErrorMessage']
      rescue JSON::ParserError
        body
      end

      if request.respond_to?(:options)
        request.options[:user] = '***'
        request.options[:password] = '***'
      end

      message = "error #{code} while sending #{request.inspect} to #{url} with #{params.inspect}"
      error_details = body.inspect
      hint = "Please see https://dev.mailjet.com/email/reference/overview/errors/ for more informations on error numbers."

      super("#{message}\n\n#{error_details}\n\n#{hint}\n\n")
    end
  end

  class CommunicationError < Error
    attr_reader :code

    NOCODE = 000

    def initialize(message = nil, response = nil)
      @response = response
      @code = if response.nil?
                NOCODE
              else
                response.response_status
              end

      api_message = begin
        Yajl::Parser.parse(response.response_body)['ErrorMessage']
      rescue Yajl::ParseError
        response.response_body
      rescue NoMethodError
        "Unknown API error"
      rescue
        'Unknown API error'
      end

      message ||=  ''
      api_message ||= ''
      message = message + ': ' + api_message

      super(message, response)
    rescue NoMethodError, JSON::ParserError
      @code = NOCODE
      super(message, response)
    end
  end

  class Unauthorized < CommunicationError
    CODE = 401

    def initialize(error_message, response)
      error_message = error_message + ' - Invalid Domain or API key'
      super(error_message, response)
    end
  end

  class BadRequest < CommunicationError
    CODE = 400

    def initialize(error_message, response)
      super(error_message, response)
    end
  end
end
