# encoding: utf-8
require "minitest_helper"

describe Mailjet::Api do
  describe "#method_missing" do
    it "should create an ApiRequest" do
      
      request = mock(:response => true)
      Mailjet::ApiRequest.expects(:new).with(:user_infos ,{:param1 => 1}, 'Post', Mailjet.config.api_key, Mailjet.config.secret_key).returns(request)
      Mailjet::Api.new.user_infos({:param1 => 1}, 'Post')
    end
  end
end