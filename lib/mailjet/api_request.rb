# encoding: utf-8

require 'active_support/core_ext/string/inflections'
require 'net/http'
require "net/https"
require 'json'
require 'cgi'

module Mailjet
  class ApiRequest
    MAILJET_HOST = 'api.mailjet.com'

    def initialize(method_name, params = {}, request_type = nil, auth_user = Mailjet.config.api_key, auth_password = Mailjet.config.secret_key)
      @method_name = method_name.to_s.camelize(:lower)
      @params = (params || {}).merge(:output => 'json')
      @request_type = (request_type || guess_request_type).camelize
      @auth_user = auth_user
      @auth_password = auth_password
    end

    def response
      @response ||= begin
        http = Net::HTTP.new(MAILJET_HOST, request_port)
        http.use_ssl = Mailjet.config.use_https
        res = http.request(request)
        
        case res
          when Net::HTTPSuccess
            JSON.parse(res.body || '{}')
          when Net::HTTPNotModified
            {"status" => "NotModified"}
          else
            raise ApiError.new(res.code, JSON.parse(res.body.presence || '{}'), request, request_path, @params)
        end
      end
    end

    private
    def request
      @request ||= begin
        puts "request == #{request_path.inspect}"
        req = "Net::HTTP::#{@request_type}".constantize.new(request_path)
        Net::HTTP::Get
        req.basic_auth @auth_user, @auth_password
        req.set_form_data(@params)
        req
      end
    end

    def request_path
      @request_path ||= begin
        path = "/#{Mailjet.config.api_version}/#{@method_name}"
        if @request_type == 'Get'
          path <<  '?' + @params.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.join('&')
        end
        path
      end
    end

    def request_port
      Mailjet.config.use_https ? 443 : 80
    end

    def guess_request_type
      if @method_name =~ /(?:Create|Add|Remove|Delete|Update)(?:[A-Z]|$)/
        'Post'
      else
        'Get'
      end
    end
  end
end