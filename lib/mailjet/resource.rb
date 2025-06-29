require 'mailjet/connection'
require 'yajl'
require 'active_support'
require 'active_support/core_ext/string'
require 'active_support/core_ext/hash/indifferent_access'



# This option automatically transforms the date output by the API into something a bit more readable.
# Setting this option to 'true' -- or having it at all -- may effect a users app by globally implementing this
# date transformation feature which may not be desired by the developer for whatever reason.
#
# ActiveSupport.parse_json_times = false

module Mailjet
  module Resource
    # define here available options for filtering
    OPTIONS = [:version, :url, :perform_api_call, :api_key, :secret_key]

    NON_JSON_URLS = ['v3/send/message'] # urls that don't accept JSON input
    DATA_URLS = ['plain', 'csv'] # url for send binary data , 'CSVError/text:csv'

    def self.included(base)
      base.extend ClassMethods
      base.class_eval do
        cattr_accessor :resource_path, :public_operations, :read_only, :filters, :resourceprop, :read_only_attributes, :action, :non_json_urls, :version
        cattr_writer :connection

        self.read_only_attributes = []

        def self.connection(options = {})
          class_variable_get(:@@connection) || default_connection(options)
        end

        def self.default_connection(options = {})
          Mailjet::Connection.new(
            "#{options[:url]}/#{options[:version]}/#{resource_path}",
            options[:api_key] || Mailjet.config.api_key,
            options[:secret_key] || Mailjet.config.secret_key,
            public_operations: public_operations,
            read_only: read_only,
            perform_api_call: options[:perform_api_call])
        end

        def self.default_headers
          if NON_JSON_URLS.include?(self.resource_path) # don't use JSON if Send API
            default_headers = { 'Accept' =>'application/json', 'Accept-Encoding' => 'deflate' }
          elsif DATA_URLS.any? do |data_type|
            default_headers = { 'Content-Type' => "text/#{data_type}" } if self.resource_path.include?(data_type)
            end
          else
            # use JSON if *not* Send API
            default_headers = {'Content-Type' =>'application/json', 'Accept' =>'application/json', 'Accept-Encoding' => 'deflate'}
          end
          return default_headers.merge!('User-Agent' => "mailjet-api-v3-ruby/#{Gem.loaded_specs["mailjet"].version}")
        end
      end
    end

    module ClassMethods
      def first(params = {}, options = {})
        all(params.merge!(limit: 1), options).first
      rescue Mailjet::ApiError => error
        raise error
      end

      def all(params = {}, options = {})
        opts = define_options(options)
        params = format_params(params)
        response = connection(opts).get(default_headers.merge!(params: params))
        attribute_array = parse_api_json(response.body)
        attribute_array.map{ |attributes| instanciate_from_api(attributes) }
      rescue Mailjet::ApiError => error
        raise error
      end

      def count(options = {})
        opts = define_options(options)
        response_json = connection(opts).get(default_headers.merge!(params: {limit: 1, countrecords: 1}))
        response_hash = Yajl::Parser.parse(response_json.body)
        response_hash['Total']
      rescue Mailjet::ApiError => error
        raise error
      end

      def find(id, job_id = nil, options = {})
        normalized_id = if id.is_a? String
          URI.encode_www_form_component(id)
        else
          id
        end

        # if action method, ammend url to appropriate id
        opts = define_options(options)
        self.resource_path = create_action_resource_path(normalized_id, job_id) if self.action

        attributes = parse_api_json(connection(opts)[normalized_id].get(default_headers).body).first
        instanciate_from_api(attributes)

      rescue Mailjet::CommunicationError => e
        if e.code == 404
          nil
        else
          raise e
        end
      end


      def find_by_id(id, options = {})
        # if action method, ammend url to appropriate id
        opts = define_options(options)
        self.resource_path = create_action_resource_path(id) if self.action
        connection(opts).get(default_headers)
      end

      def create(attributes = {}, options = {})
        # if action method, ammend url to appropriate id
        opts = define_options(options)
        self.resource_path = create_action_resource_path(attributes[:id]) if (self.action and attributes[:id])
        attributes.tap { |hs| hs.delete(:id) }

        if Mailjet.config.default_from and self.resource_path == 'send/'
          address = Mail::AddressList.new(Mailjet.config.default_from).addresses[0]
          default_attributes = { :from_email => address.address, :from_name => address.display_name}
        else
          default_attributes = {}
        end

        attributes = default_attributes.merge(attributes)

        self.new(attributes).tap do |resource|
          resource.save!(opts)
          resource.attributes[:persisted] = true
        end
      end

      def delete(id, options = {})
         # if action method, ammend url to appropriate id
         opts = define_options(options)
         self.resource_path = create_action_resource_path(id) if self.action
         connection(opts)[id].delete(default_headers)
      rescue Mailjet::ApiError => error
        raise error
      end

      def send_data(id, binary_data = nil, options = {})
        opts = define_options(options)
        self.resource_path = create_action_resource_path(id) if self.action
        response = connection(opts).post(binary_data, default_headers.merge({'Content-Length' => "#{binary_data.size}", 'Transfer-Encoding' => 'chunked'}))

        response_hash = response.respond_to?(:body) ? Yajl::Parser.parse(response.body) : Yajl::Parser.parse(response)
        response_hash['ID'] ? response_hash['ID'] : response_hash
      end

      def instanciate_from_api(attributes = {})
        self.new(attributes.merge!(persisted: true))
      end

      def parse_api_json(response_json)
        response_hash = Yajl::Parser.parse(response_json)

        #Take the response from the API and put it through a method -- taken from the ActiveSupport library -- which converts
        #the date-time from "2014-05-19T15:31:09Z" to "Mon, 19 May 2014 15:31:09 +0000" format.
        response_hash = convert_dates_from(response_hash)

        if response_hash['Data']
          response_data_array = response_hash['Data']
        else
          response_data_array = response_hash
        end
        response_data_array.map{ |response_data| underscore_keys(response_data) }
      end

      def create_action_resource_path(id, job_id = nil)
        url_elements = self.resource_path.split("/")
        url_elements.delete_at(url_elements.length-1) if url_elements.last.to_i > 0 #if there is a trailing number for the job id from last call, delete it

        if !(url_elements[1] == "contacts" && self.action == "managemanycontacts")
          url_elements[2] = id.to_s
        end

        url_elements << job_id.to_s if job_id #if job_id exists, amend it to end of the URI
        url = url_elements.join("/")

        return url
      end


      # Method -- taken from the ActiveSupport library -- which converts the date-time from
      #"2014-05-19T15:31:09Z" to "Mon, 19 May 2014 15:31:09 +0000" format.
      #We may have to change this in the future if ActiveSupport's JSON implementation changes
      def convert_dates_from(data)
        case data
        when nil
          nil
        when /^(?:\d{4}-\d{2}-\d{2}|\d{4}-\d{1,2}-\d{1,2}[T \t]+\d{1,2}:\d{2}:\d{2}(\.[0-9]*)?(([ \t]*)Z|[-+]\d{2}?(:\d{2})?))$/
          begin
            DateTime.iso8601(data)
          rescue ArgumentError
            data
          end
        when Array
          data.map! { |d| convert_dates_from(d) }
        when Hash
          data.each do |key, value|
            data[key] = convert_dates_from(value)
          end
        else
          data
        end
      end


      def format_params(params)
        if params[:sort]
          params[:sort] = params[:sort].map do |attribute, direction|
            attribute = attribute.to_s.camelcase
            direction = direction.to_s.upcase
            "#{attribute} #{direction}"
          end.join(', ')
        end
        camelcase_keys params
      end

      def camelcase_keys(hash)
        map_keys(hash, :camelcase)
      end

      def underscore_keys(hash)
        map_keys(hash, :underscore)
      end

      def map_keys(hash, method)
        hash.inject({}) do |_hash, (key, value)|
          # new_key = key.to_s.send(method)
          new_key =
            if key == "text_part"
              'Text-part'
            elsif key == "html_part"
              'Html-part'
            elsif key == "inline_attachments"
              'Inline_attachments'
            else
              key.to_s.send(method)
            end
          _hash[new_key] = value
          _hash
        end
      end

      def define_options(options = {})
        # merge default options with given ones on-the-fly
        {
          version: version || Mailjet.config.api_version,
          url: Mailjet.config.end_point,
          perform_api_call: Mailjet.config.perform_api_call
        }
        .merge(options.symbolize_keys.slice(*OPTIONS))
      end

    end

    attr_accessor :attributes, :persisted

    def initialize(_attributes = nil)
      @attributes = ActiveSupport::HashWithIndifferentAccess.new(_attributes.reverse_merge(persisted: false))
    end

    def persisted?
      attributes[:persisted]
    end

    def save(options = {})
      opts = self.class.define_options(options)

      if persisted?
        # case where the entity is updated
        response = connection(opts)[attributes[:id]].put(formatted_payload, default_headers)
      else
        # case where the entity is created
        response = connection(opts).post(formatted_payload, default_headers)
      end

      if opts[:perform_api_call] && !persisted?
        # get attributes only for entity creation
        self.attributes = if self.resource_path == 'send'
          Yajl::Parser.parse(response.body)
        else
          parse_api_json(response.body).first
        end
      end

      return true

    rescue Mailjet::ApiError => e
      if e.code.to_s == "304"
        return true # When you save a record twice it should not raise error
      else
        raise e
      end
    end

    def save!(options = {})
      save(options) || raise(StandardError.new("Resource not persisted"))
    end

    def attributes=(attribute_hash = {})
      attribute_hash.each do |attribute_name, value|
        self.send("#{attribute_name}=", value)
      end
    end

    def update_attributes(attribute_hash = {}, options = {})
      self.attributes.deep_merge!(attribute_hash) do |key, old, new|
        if old.is_a?(Array) && new.is_a?(Array)
          # uniqueness of hashes based on their value of "Name"
          (new + old).uniq do |data|
            data["Name"]
          end
        else
          new
        end
      end

      opts = self.class.define_options(options)
      save(opts)
    end

    def delete
      self.class.delete(id)
    end

    private

    def connection(options)
      self.class.connection(options)
    end

    def default_headers
      self.class.default_headers
    end

    def formatted_payload
      payload = attributes.reject { |k,v| v.blank? }
      if persisted?
        payload = payload.slice(*resourceprop.map(&:to_s))
          .except(*read_only_attributes.map(&:to_s))
      end
      payload = camelcase_keys(payload)
      payload.tap { |hs| hs.delete("Persisted") }
      payload.inject({}) do |h, (k, v)|
        if v.respond_to? :utc
          v = v.utc.to_s
        end
        h.merge!({k => v})
      end
    end

    def camelcase_keys(hash)
      self.class.camelcase_keys(hash)
    end

    def underscore_keys(hash)
      self.class.underscore_keys(hash)
    end

    def parse_api_json(response_json)
      self.class.parse_api_json(response_json)
    end

    def convert_dates_from(data)
      self.class.convert_dates_from(data)
    end

    def method_missing(method_symbol, *arguments) #:nodoc:
      method_name = method_symbol.to_s
      if method_name.end_with?("=")
        attributes[method_name.chop] = arguments.first
        return
      end

      if attributes.include?(method_name)
        return attributes[method_name]
      end

      super
    end

    def respond_to_missing?(method_name, include_private = false)
      method_name_str = method_name.to_s.gsub(/[=?]$/, '')
      attributes.include?(method_name_str) || super
    end
  end
end
