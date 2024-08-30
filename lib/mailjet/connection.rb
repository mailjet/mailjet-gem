require 'faraday'
require 'yajl'

module Mailjet
  class Connection

    attr_accessor :adapter, :public_operations, :read_only, :perform_api_call, :api_key, :secret_key, :options
    alias :read_only? :read_only

    def [](suburl, &new_block)
      broken_url = uri.path.split("/")
      if broken_url.include?("contactslist") && broken_url.include?("managemanycontacts") && broken_url.last.to_i > 0
        self.class.new(uri, api_key, secret_key, options)
      else
        self.class.new(concat_urls(suburl), api_key, secret_key, options)
      end
    end

    def initialize(end_point, api_key, secret_key, options = {})
      self.options = options
      self.api_key = api_key
      self.secret_key = secret_key
      self.public_operations = options[:public_operations] || []
      self.read_only = options[:read_only]
      self.adapter = Faraday.new(end_point, ssl: { verify: false }) do |conn|
        conn.response :raise_error, include_request: true
        conn.request :authorization, :basic, api_key, secret_key
        conn.headers['Content-Type'] = 'application/json'
      end
      self.perform_api_call = options.key?(:perform_api_call) ? options[:perform_api_call] : true
    end

    def get(additional_headers = {}, &block)
      handle_api_call(:get, additional_headers, &block)
    end

    def post(payload, additional_headers = {}, &block)
      handle_api_call(:post, additional_headers, payload, &block)
    end

    def put(payload, additional_headers = {}, &block)
      handle_api_call(:put, additional_headers, payload, &block)
    end

    def delete(additional_headers = {}, &block)
      handle_api_call(:delete, additional_headers, &block)
    end

    def concat_urls(suburl)
      self.adapter.build_url(suburl.to_s)
    end

    def uri
      self.adapter.build_url
    end

    private

    def handle_api_call(method, additional_headers = {}, payload = {}, &block)
      formatted_payload = (additional_headers["Content-Type"] == 'application/json') ? Yajl::Encoder.encode(payload) : payload
      raise Mailjet::MethodNotAllowed unless method_allowed(method)

      if self.perform_api_call
        if [:get, :delete].include?(method)
          @adapter.send(method, nil, additional_headers[:params], &block)
        else
          @adapter.send(method, nil, formatted_payload, additional_headers, &block)
        end
      else
        return Yajl::Encoder.encode({'Count' => 0, 'Data' => [mock_api_call: true], 'Total' => 0})
      end

    rescue Faraday::Error => e
      handle_exception(e, additional_headers, formatted_payload)
    end

    def method_allowed(method)
      method = method.to_sym
      public_operations.include?(method) && (method == :get || !read_only?)
    end

    def handle_exception(e, additional_headers, payload = {})
      return e.response_body if e.response_headers[:content_type].include?("text/plain")

      params = additional_headers[:params] || {}
      formatted_payload = (additional_headers[:content_type] == :json) ? Yajl::Parser.parse(payload) : payload
      params = params.merge!(formatted_payload) if formatted_payload.is_a?(Hash)

      response_body = if e.response_headers[:content_type].include?("application/json")
        e.response_body
      else
        "{}"
      end

      if sent_invalid_email?(e.response_body, @adapter.build_url)
        return e.response_body
      else
        raise communication_error(e)
      end
    end

    def communication_error(e)
      if e.respond_to?(:response) && e.response
        return case e.response_status
        when Unauthorized::CODE
          Unauthorized.new(e.message, e)
        when BadRequest::CODE
          BadRequest.new(e.message, e)
        else
          CommunicationError.new(e.message, e)
        end
      end
      CommunicationError.new(e.message)
    end

    def sent_invalid_email?(error_http_body, uri)
      return false unless uri.path.include?('v3.1/send')
      return unless error_http_body

      parsed_body = Yajl::Parser.parse(error_http_body)
      error_message = parsed_body.dig('Messages')&.first&.dig('Errors')&.first&.dig('ErrorMessage') || []
      error_message.include?('is an invalid email address.')
    rescue
      false
    end

  end

  class MethodNotAllowed < StandardError
  end
end
