require 'minitest_helper'

describe Mailjet::Reporting do
  it 'has an integration suite, tested directly against Mailjet service' do
    # Mailjet::Reporting.clicks
    Mailjet::Reporting.clicks.must_be_instance_of Array
    
    # Mailjet::Reporting.domains
    Mailjet::Reporting.domains.must_be_instance_of Array
    
    # Mailjet::Reporting.clients
    Mailjet::Reporting.clients.must_be_instance_of Array
    
    # Mailjet::Reporting.emails
    Mailjet::Reporting.emails.must_be_instance_of Array
    
    # Mailjet::Reporting.statistics
    Mailjet::Reporting.statistics["cnt_messages"].wont_be_nil

    # Mailjet::Reporting.geolocation
    Mailjet::Reporting.geolocation.must_be_instance_of Hash

    # Mailjet::Reporting.agents
    Mailjet::Reporting.agents.must_be_instance_of Array
  end
end