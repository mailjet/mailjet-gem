require "mailjet_spec_helper"

RSpec.describe Mailjet::Template_detailcontent do
  describe ".find" do
    before { Mailjet.config.api_version = "v3" }

    it "returns correct content", :vcr do
      content = Mailjet::Template_detailcontent.find(1715745)
      attrs = content.attributes

      expect(attrs["html_part"]).to eq "Hello"
      expect(attrs["headers"]).to eq({
        "From" => "pilot@example.com",
        "Subject" => "Your email flight plan!"
      })
    end

    it "returns nil when template not found", :vcr do
      content = Mailjet::Template_detailcontent.find(123)

      expect(content).to be_nil
    end
  end
end
