require "minitest_helper"

SAMPLE_MAILJET_PAYLOAD = "{\"event\":\"open\",\"time\":1331581827,\"email\":\"benoit.benezech+1634@gmail.com\",\"mj_campaign_id\":\"105881975\",\"mj_contact_id\":\"116408391\",\"customcampaign\":null,\"ip\":\"88.164.20.58\",\"geo\":\"FR\",\"agent\":\"Mozilla\\/5.0 (Macintosh; Intel Mac OS X 10_7_2) AppleWebKit\\/535.11 (KHTML, like Gecko) Chrome\\/17.0.963.79 Safari\\/535.11\"}"

describe Mailjet::Rack::Endpoint do
  it "should decipher Mailjet's posted events" do
    skip 'TODO tmrw, goto sleep'
  end
end