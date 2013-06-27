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
    campaign.update(:title => "My *new* Mailjet Campaign")

    # Mailjet::Campaign#duplicate
    dup = campaign.duplicate(:title => "My *new* Mailjet Campaign")
    dup.must_be_instance_of Mailjet::Campaign
    dup.id.wont_be_same_as campaign.id

    # Mailjet::Campaign#send!
    campaign.send!.must_equal 'OK'

    # Mailjet::Campaign#test
    campaign.test('benoit.benezech@gmail.com').must_equal 'OK'

    # Mailjet::Campaign#html
    campaign.html.must_be_nil

    # Mailjet::Campaign#set_html
    html_test = "<html><head><title>Test</title></head><body>Test <a href=\"[[UNSUB_LINK_EN]]\">[[UNSUB_LINK_EN]]</a></body></html>"
    dup.set_html(html_test).must_equal 'OK'
    dup.html.must_equal html_test

    sleep 20 # wait for the campaign to be send
    campaign = Mailjet::Campaign.find(campaign.id)

    # Mailjet::Campaign#contacts
    campaign.contacts.wont_be_empty

    # Mailjet::Campaign#statistics
    campaign.statistics.keys.must_include "blocked"
  end
end
