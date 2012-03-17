# encoding: utf-8
require 'active_support'

module Mailjet  
  class ApiError < StandardError
    def initialize(code, res)
      super("error #{code}\n\n" + 
        "Mailjet replied:\n\n" +
        (res['errors'].present? ? 
          (res['errors'] || []).map do |param, text|
            "#{param}: #{text}"
          end.join("\n") : 
          res.inspect
        ) +
        "\n\nPlease see http://api.mailjet.com/0.1/HelpStatus for more informations.\n\n"
      )
    end
  end
end