require "mailjet_spec_helper"

RSpec.describe Mailjet::Connection do
  let(:end_point) { "https://api.mailjet.com/v3/REST/contact" }
  let(:options) { { public_operations: [:get] } }

  subject(:connection) { described_class.new(end_point, "key", "secret", options) }

  describe "TLS" do
    it "verifies server certificates" do
      expect(connection.adapter.ssl.verify?).to be true
    end

    it "keeps verifying certificates on sub-resource connections" do
      expect(connection[42].adapter.ssl.verify?).to be true
    end
  end
end
