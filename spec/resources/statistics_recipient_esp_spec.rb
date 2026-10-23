require "mailjet_spec_helper"

RSpec.describe Mailjet::Statistics_recipient_esp do
  before { Mailjet.config.api_version = "v3" }

  describe ".all" do
    let(:connection) { instance_double("Connection") }
    let(:response) do
      instance_double(
        Faraday::Response,
        body: '{"Count":1,"Data":[{"ESPName":"gmail","DeliveredMessagesCount":9,"OpenRate":0.5}],"Total":1}'
      )
    end

    before { described_class.connection = connection }
    after { described_class.connection = nil }

    it "sends the campaign and ESP filters" do
      expect(connection).to receive(:get)
        .with(hash_including(params: { "CampaignId" => 123, "ESP_Name" => "gmail" }))
        .and_return(response)

      described_class.all(campaign_id: 123, esp_name: "gmail")
    end

    it "returns statistics per ESP" do
      allow(connection).to receive(:get).and_return(response)

      stats = described_class.all(campaign_id: 123)

      expect(stats.first.esp_name).to eq "gmail"
      expect(stats.first.delivered_messages_count).to eq 9
      expect(stats.first.open_rate).to eq 0.5
    end
  end

  describe ".all against the API", :vcr do
    it "returns statistics per ESP for a campaign" do
      stats = described_class.all(campaign_id: 7759404292)

      microsoft = stats.find { |row| row.esp_name == "microsoft" }
      expect(microsoft.attempted_messages_count).to eq 1
      expect(microsoft.delivered_messages_count).to eq 1
    end

    it "returns only the ESP passed as esp_name" do
      stats = described_class.all(campaign_id: 7759404292, esp_name: "microsoft")

      expect(stats.map(&:esp_name)).to eq ["microsoft"]
    end
  end
end
