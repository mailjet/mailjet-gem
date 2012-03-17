require 'mailjet/api'

module Mailjet
  class TemplateModel < OpenStruct
    class << self      
      def all(options = {})
        (options.delete(:api) || Mailjet::Api.singleton).messageTplmodels(options)["templates"].map do |result_hash|
          self.new(result_hash)
        end
      end
    end
  end
end