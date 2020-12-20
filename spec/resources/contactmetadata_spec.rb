require "mailjet_spec_helper"

RSpec.describe Mailjet::Contactmetadata, :vcr do
  before { Mailjet.config.api_version = "v3" }

  describe "#persisted?" do
    it "returns true for created resource" do
      res = described_class.create(datatype: "str", name: "middle_name", name_space: "static")
      expect(res.persisted?).to eq true
    end

    it "returns true on existing resource" do
      res = described_class.find(65942)
      expect(res.persisted?).to eq true
    end
  end
end
