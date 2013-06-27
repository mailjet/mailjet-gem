require 'minitest_helper'

describe Mailjet::List do
  it 'has an integration suite, tested directly against Mailjet service' do
    # clean-up all existing lists:
    Mailjet::List.all.each do |list|
      list.delete
    end
    
    # Mailjet::List.all for no lists
    Mailjet::List.all.must_be_empty
    
    # Mailjet::List#create
    list = Mailjet::List.create(:label => 'My Mailjet list', :name => "mymailjetlist")
    list.must_be_instance_of Mailjet::List
    list.label.must_equal 'My Mailjet list'
    list.name.must_equal 'mymailjetlist'
    
    # Mailjet::List#update.
    list.update(:label => 'My updated Mailjet list', :name => "myupdatedmailjetlist").must_equal "OK"
    updated_list = Mailjet::List.all.first
    updated_list.label.must_equal 'My updated Mailjet list'
    updated_list.name.must_equal 'myupdatedmailjetlist'
    updated_list.id.must_equal list.id
    
    # Mailjet::List.all
    lists = Mailjet::List.all
    lists.count.must_equal 1
    lists.first.must_be_instance_of Mailjet::List
    lists.first.id.must_equal updated_list.id
    
    # Mailjet::List#add_contacts
    list.add_contacts.must_equal "NotModified"
    list.add_contacts("c1@contacts.com").must_equal "OK"
    list.add_contacts("c1@contacts.com").must_equal "NotModified"
    list.add_contacts("c2@contacts.com", "c3@contacts.com").must_equal "OK"
    list.add_contacts("c4@contacts.com", "c5@contacts.com").must_equal "OK"
    
    # Mailjet::List#contacts and validate results of add_contacts
    contacts = list.contacts
    contacts.first.must_be_instance_of Mailjet::Contact
    contacts.map(&:email).sort.must_equal ["c1@contacts.com", "c2@contacts.com", "c3@contacts.com", "c4@contacts.com", "c5@contacts.com"]

    # Mailjet::List#unsubscribe_contact
    list.unsubscribe_contact("c1@contacts.com").must_equal "OK"
    exception = proc {list.unsubscribe_contact("c1@contacts.com")}.must_raise(Mailjet::ApiError)
    exception.to_s.must_match /This contact is already unsub./

    # Mailjet::List#remove_contacts
    list.remove_contacts.must_equal "NotModified"
    list.remove_contacts("does-not-exist@nowhere.com").must_equal "NotModified"
    list.remove_contacts("c1@contacts.com", "c2@contacts.com").must_equal "OK"
    list.contacts.count.must_equal 3
    
    # Mailjet::List#email
    list.email.must_match /\@lists\.mailjet\.com$/
    
    # Mailjet::List#statistics
    list.statistics["sent"].must_equal "0"
    
    # Mailjet::List#delete
    list.delete.must_equal 'OK'
    Mailjet::List.all.must_be_empty
    exception = proc { list.delete }.must_raise(Mailjet::ApiError)
    exception.to_s.must_match /This ID not appears to be an active list on your account/
  end
end
