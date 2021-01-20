require "mailjet_spec_helper"

RSpec.describe Mailjet do
  describe ".configure" do
    it "permits to set api keys and remembers them" do
      Mailjet.configure do |config|
        config.api_key = "1234"
        config.secret_key = "5678"
        config.default_from = "default from test"
      end

      expect(Mailjet.config.api_key).to eq "1234"
      expect(Mailjet.config.secret_key).to eq "5678"
      expect(Mailjet.config.default_from).to eq "default from test"
    end
  end
end
