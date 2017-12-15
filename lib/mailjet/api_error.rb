# encoding: utf-8
require 'active_support'

module Mailjet
  class ApiError < StandardError

    attr_accessor :code, :reason


    def initialize(code, res, request, request_path, params)
      self.code = code
      self.reason = ""
      message = "error #{code} while sending #{request.inspect} to #{request_path} with #{params.inspect}\n\n"
      if res
        begin
          resdec = ActiveSupport::JSON.decode(res)
          self.reason = resdec['ErrorMessage']
          message += "ErorMessage: #{self.reason}\n"
          if resdec['errors'].present?
            message += "errors: " + [(resdec['errors'] || [])].flatten.map do |param, text|
              [param, text].map(&:to_s).reject(&:blank?).join(': ')
            end.join("\n")
          else
            message += res.inspect
          end
        rescue ActiveSupport::JSON.parse_error
          message += res.inspect
        end
      end

      super(
        message + 
          "\n\nPlease see https://dev.mailjet.com/guides/#status-codes for more informations on error numbers.\n\n"
      )
    end
  end
end
