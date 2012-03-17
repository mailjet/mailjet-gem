require 'mailjet/api'
require 'mailjet/contact'

module Mailjet
  class List < OpenStruct
    def update(options = {})
      (options.delete(:api) || Mailjet::Api.singleton).listsUpdate(options.reverse_merge(:id => self.id))["status"]
    end
    
    def add_contacts(*params)
      options = params.last.is_a?(Hash) ? params.pop : {}
      contacts = params.map{|p| p.is_a?(Mailjet::Contact) ? p.email.to_s : p.to_s }.reject(&:blank?)
      (options.delete(:api) || Mailjet::Api.singleton).listsAddmanycontacts(options.reverse_merge(:contacts => contacts.to_json, :id => self.id), 'Post')["status"]
    end
    
    def remove_contacts(*params)
      options = params.last.is_a?(Hash) ? params.pop : {}
      contacts = params.map{|p| p.is_a?(Mailjet::Contact) ? p.email.to_s : p.to_s }.reject(&:blank?)
      (options.delete(:api) || Mailjet::Api.singleton).listsRemovemanycontacts(options.reverse_merge(:contacts => contacts.to_json, :id => self.id), 'Post')["status"]
    end
    
    def contacts(options = {})
      (options.delete(:api) || Mailjet::Api.singleton).listsContacts(options.reverse_merge(:id => self.id))["result"].map do |contact|
        Mailjet::Contact.new(contact)
      end
    end
    
    def email(options = {})
      (options.delete(:api) || Mailjet::Api.singleton).listsEmail(options.reverse_merge(:id => self.id))["email"]
    end
    
    def statistics(options = {})
      (options.delete(:api) || Mailjet::Api.singleton).listsStatistics(options.reverse_merge(:id => self.id))["statistics"]
    end
    
    def delete(options = {})
      (options.delete(:api) || Mailjet::Api.singleton).listsDelete(options.reverse_merge(:id => self.id))["status"]
    end
        
    class << self
      def create(options = {})
        self.new(options.merge(:id => (options.delete(:api) || Mailjet::Api.singleton).listsCreate(options)["list_id"]))
      end
      
      def all(options = {})
        (options.delete(:api) || Mailjet::Api.singleton).listsAll(options)["lists"].map do |result_hash|
          self.new(result_hash)
        end
      end
    end
  end
end