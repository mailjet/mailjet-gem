require "mailjet_spec_helper"

RSpec.describe Mailjet::Campaigndraft_detailcontent do
  describe ".find" do
    before { Mailjet.config.api_version = "v3" }

    it "returns an array of content objects", :vcr do
      contents = described_class.find(15068571)

      expect(contents).to be_an(Array)
      expect(contents.size).to eq 1
      expect(contents.first).to be_a(described_class)
      expect(contents.first.attributes).to include(
        "text_part" => "Test campaign sent to record specs for the mailjet gem.",
        "html_part" => "<p>Test campaign sent to record specs for the mailjet gem.</p>"
      )
    end

    it "returns nil when draft not found", :vcr do
      expect(described_class.find(123)).to be_nil
    end
  end
end
