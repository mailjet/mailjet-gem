require 'mailjet/api'

module Mailjet
  class TemplateCategory < OpenStruct
    class << self      
      def all(options = {})
        (options.delete(:api) || Mailjet::Api.singleton).messageTplcategories(options)["categories"].map do |result_hash|
          self.new(result_hash)
        end
      end
    end
  end
end