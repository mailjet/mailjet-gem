require 'rest_client'
require 'mailjet/gem_extensions/rest_client'
require 'active_support/core_ext/module/delegation'

module Mailjet
  class Connection

    attr_accessor :adapter, :public_operations, :read_only
    alias :read_only? :read_only

    delegate :options, :concat_urls, :url, to: :adapter

    def [](suburl, &new_block)
      self.class.new(concat_urls(url, suburl), options[:user], options[:password], options)
    end

    def initialize(end_point, api_key, secret_key, options = {})
      adapter_class = options[:adapter_class] || RestClient::Resource
      self.public_operations = options[:public_operations] || []
      self.read_only = options[:read_only]
      ## If .crt file exists, use in API call.  If not, do not because you are using the production API
      if File.exists?(Mailjet::Configuration.path_to_crt)
        self.adapter = adapter_class.new(end_point, options.merge(user: api_key, password: secret_key, :ssl_ca_file  =>  Mailjet::Configuration.path_to_crt))
      else
        self.adapter = adapter_class.new(end_point, options.merge(user: api_key, password: secret_key))
      end
      ##
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

    private

    def handle_api_call(method, additional_headers = {}, payload = {}, &block)
      raise Mailjet::MethodNotAllowed unless method_allowed(method)

      if [:get, :delete].include?(method)
        @adapter.send(method, additional_headers, &block)
      else
        @adapter.send(method, payload, additional_headers, &block)
      end
    rescue RestClient::Exception => e
      handle_exeception(e, additional_headers, payload)
    end

    def method_allowed(method)
      method = method.to_sym
      public_operations.include?(method) && (method == :get || !read_only?)
    end

    def handle_exeception(e, additional_headers, payload = {})
      params = additional_headers[:params] || {}
      params = params.merge(payload)

      raise Mailjet::ApiError.new(e.http_code, e.http_body, @adapter, @adapter.url, params)
    end

  end

  class MethodNotAllowed < StandardError

  end
end
