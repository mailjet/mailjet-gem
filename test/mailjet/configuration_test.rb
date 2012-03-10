require "minitest_helper"

describe Mailjet::Configuration do
  describe "accessors" do
    it "should memorize values" do
      Mailjet::Configuration.api_key = '1234'
      Mailjet::Configuration.api_key.must_equal '1234'
    end
  end

  describe "#use_https" do
    it "should be true by default" do
      Mailjet::Configuration.use_https.must_equal true
    end
  end
end