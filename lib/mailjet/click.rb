require 'mailjet/api'
require 'mailjet/contact'
require 'mailjet/email'

module Mailjet
  class Click < OpenStruct    
    def contact
      Mailjet::Contact.new(:email => self.by_email, :id => self.by_id)
    end
    
    def email
      Mailjet::Email.new(:id => self.email_id)
    end
  end
end