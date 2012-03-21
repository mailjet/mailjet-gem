require 'minitest_helper'

describe Mailjet::Campaign do
  it 'has an integration suite, tested directly against Mailjet service' do
    
    # init
    Mailjet::List.all.each do |list|
      list.delete
    end
    list = Mailjet::List.create(:label => 'My Mailjet list', :name => "mymailjetlist")
    list.add_contacts("c1@contacts.com", "c2@contacts.com")
    
    # Mailjet::Campaign.create
    campaign = Mailjet::Campaign.create(
      :title => "My Mailjet Campaign", 
      :list_id => list.id,
      :from => Mailjet.config.default_from, # must be valid
      :from_name => "Sender Name", 
      :subject => "Our new product", 
      :template_id => Mailjet::TemplateModel.all.first.id,
      :lang => "en", 
      :footer => "default"
    )
    campaign.url.must_match /^https\:\/\/www\.mailjet\.com\/campaigns\/template\/[0-9]+$/
    
    # Mailjet::Campaign.all
    campaigns = Mailjet::Campaign.all
    campaigns.wont_be_empty # we can't empty the whole campaign list...
    campaigns.first.must_be_instance_of Mailjet::Campaign
    
    # Mailjet::Campaign.find
    Mailjet::Campaign.find(campaign.id).must_be_instance_of Mailjet::Campaign
    Mailjet::Campaign.find(0).must_be_nil
    
    # Mailjet::Campaign#update
    # campaign.update(:title => "My *new* Mailjet Campaign")
    # TODO does not work, asks for an id even if present.
    
    # Mailjet::Campaign#duplicate
    dup = campaign.duplicate(:title => "My *new* Mailjet Campaign")
    dup.must_be_instance_of Mailjet::Campaign
    dup.id.wont_be_same_as campaign.id
        
    # Mailjet::Campaign#contacts
    # campaign.contacts.wont_be_empty
    # TODO does not work, always returns {}, even when list_id is passed with a list that contains emails.
    
    # Mailjet::Campaign#send!
    # campaign.send!.must_equal 'OK'
    # TODO does not work, 500 server side.
    
    # Mailjet::Campaign#test
    # campaign.test('benoit.benezech@gmail.com').must_equal 'OK'
    # TODO does not work, 500 server side.
    
    # Mailjet::Campaign#statistics
    campaign.statistics.keys.must_include "blocked"
    
    # Mailjet::Campaign#html
    campaign.html.must_be_nil
    # TODO how to get content in the campaign template?
    
    
    
  end
end
