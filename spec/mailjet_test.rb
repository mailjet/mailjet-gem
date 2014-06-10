require 'spec_helper'

describe Mailjet do
  describe "#configure" do
    it "should permit to set api keys and remember them" do
      Mailjet.configure do |config|
        config.api_key = "1234"
        config.secret_key = "5678"
        config.default_from = "default from test"
      end

      Mailjet.config.api_key.must_equal "1234"
      Mailjet.config.secret_key.must_equal "5678"
      Mailjet.config.default_from = "default from test"
    end
  end
end
