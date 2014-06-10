require 'spec_helper'
require 'rack/mock'

SAMPLE_MAILJET_PAYLOAD = "{\"event\":\"open\",\"time\":1331581827,\"email\":\"benoit.benezech+1634@gmail.com\",\"mj_campaign_id\":\"105881975\",\"mj_contact_id\":\"116408391\",\"customcampaign\":null,\"ip\":\"88.164.20.58\",\"geo\":\"FR\",\"agent\":\"Mozilla\\/5.0 (Macintosh; Intel Mac OS X 10_7_2) AppleWebKit\\/535.11 (KHTML, like Gecko) Chrome\\/17.0.963.79 Safari\\/535.11\"}"
SAMPLE_MAILJET_PARAMS = {"event"=>"open", "time"=>1331581827, "email"=>"benoit.benezech+1634@gmail.com", "mj_campaign_id"=>"105881975", "mj_contact_id"=>"116408391", "customcampaign"=>nil, "ip"=>"88.164.20.58", "geo"=>"FR", "agent"=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_2) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.79 Safari/535.11"}


describe Mailjet::Rack::Endpoint do
  it "should decipher Mailjet's posted events and pass them to the block" do
    # mock should receive :find with "benoit.benezech+1634@gmail.com" and will return true
    $user_class_mock = MiniTest::Mock.new.expect(:find, true, ["benoit.benezech+1634@gmail.com"])

    app = Rack::Builder.new do
      use Rack::Lint
      use Mailjet::Rack::Endpoint, '/callback' do |params|
        $user_class_mock.find(params['email'])#.do_smtg_with_the_user....
      end
      run lambda { |env|
        [200, {'Content-Type' => 'text/plain'}, ['passed through your endpoint, haha']]
      }
    end

    response = Rack::MockRequest.new(app).get('/not_callback')
    response.body.must_equal('passed through your endpoint, haha')

    response = Rack::MockRequest.new(app).post('/callback', :input => SAMPLE_MAILJET_PAYLOAD)
    response.body.must_equal('')
    $user_class_mock.verify
  end
end
