require 'minitest_helper'

describe Mailjet::Contact do
  it 'has an integration suite, tested directly against Mailjet service' do
    # init
    Mailjet::List.all.each do |list|
      list.delete
    end
    list = Mailjet::List.create(:label => 'My Mailjet list', :name => "mymailjetlist")
    list.add_contacts("c1@contacts.com")
    
    # Mailjet::Contact.all
    contacts = Mailjet::Contact.all
    contacts.wont_be :empty?  # we can't empty the whole contact list...
    contacts.first.must_be_instance_of Mailjet::Contact
    
    # Mailjet::Contact.all(:openers => true)
    # Mailjet::Contact.all(:openers => true).must_be :empty?
    # TODO :openers does not work, times out
    
    # Mailjet::Contact#infos
    contacts.first.infos["click"].wont_be_nil
  end
end
