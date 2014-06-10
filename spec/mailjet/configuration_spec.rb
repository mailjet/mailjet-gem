require 'spec_helper'

describe Mailjet::Configuration do
  describe "accessors" do
    it "should memorize values" do
      Mailjet::Configuration.api_key = '1234'
      Mailjet::Configuration.api_key.must_equal '1234'
    end
  end
end
