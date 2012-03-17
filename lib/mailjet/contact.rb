require 'mailjet/api'

module Mailjet
  class Contact < OpenStruct
    def infos(options = {})
      (options.delete(:api) || Mailjet::Api.singleton).contactInfos(options.reverse_merge(:contact => (self.id || self.email)))["contact"]
    end
    
    class << self
      def all(options = {})
        verb = options.delete(:openers) ? 'contactOpeners' : 'contactList'
        (options.delete(:api) || Mailjet::Api.singleton).send(verb, options)["result"].map do |result_hash|
          self.new(result_hash)
        end
      end
    end
  end
end