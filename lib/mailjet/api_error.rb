# encoding: utf-8
require 'active_support'

module Mailjet  
  class ApiError < StandardError
    def initialize(code, res, request, request_path, params)
      # code is ugly, output is pretty
      super("error #{code} while sending #{request.inspect} to #{request_path} with #{params.inspect}\n\n" + 
        (res['errors'].present? ? 
          (res['errors'] || []).map do |param, text|
            [param, text].map(&:to_s).reject(&:blank?).join(': ')
          end.join("\n") : 
          res.inspect
        ) +
        "\n\nPlease see http://api.mailjet.com/0.1/HelpStatus for more informations on error numbers.\n\n"
      )
    end
  end
end