require "mailjet_spec_helper"

RSpec.describe Mailjet::Statcounters, :vcr do
  describe ".all" do
    before { Mailjet.config.api_version = "v3" }

    it "returns all records" do
      res = described_class.all(
        source_id: 52387,
        counter_source: "Sender",
        counter_timing: "Message",
        counter_resolution: "Lifetime"
      )

      expect(res.count).to eq 1
      expect(res.first.attributes).to eq({
        "persisted" => true,
        "api_key_id" => 1404561,
        "event_click_delay" => 0,
        "event_clicked_count" => 0,
        "event_open_delay" => 31806,
        "event_opened_count" => 36,
        "event_spam_count" => 0,
        "event_unsubscribed_count" => 0,
        "event_workflow_exited_count" => 0,
        "message_blocked_count" => 10,
        "message_clicked_count" => 0,
        "message_deferred_count" => 0,
        "message_hard_bounced_count" => 0,
        "message_opened_count" => 12,
        "message_queued_count" => 0,
        "message_sent_count" => 44,
        "message_soft_bounced_count" => 0,
        "message_spam_count" => 0,
        "message_unsubscribed_count" => 0,
        "message_work_flow_exited_count" => 0,
        "source_id" => 52387,
        "timeslice" => "",
        "total" => 54
      })
    end

    it "returns daily counts between from_ts and to_ts" do
      res = described_class.all(
        source_id: 7759404292,
        counter_source: "Campaign",
        counter_timing: "Message",
        counter_resolution: "Day",
        from_ts: Time.utc(2026, 10, 23).to_i,
        to_ts: Time.utc(2026, 10, 24).to_i
      )

      expect(res.map(&:timeslice)).to eq ["2026-10-23T00:00:00+00:00"]
      expect(res.first.message_sent_count).to eq 1
    end
  end
end

RSpec.describe Mailjet::Statcounters do
  describe "time range filters" do
    let(:connection) { instance_double("Connection") }
    let(:response) { instance_double(Faraday::Response, body: '{"Count":0,"Data":[],"Total":0}') }

    before { described_class.connection = connection }
    after { described_class.connection = nil }

    it "declares from_ts and to_ts" do
      expect(described_class.filters).to include(:from_ts, :to_ts)
    end

    it "sends from_ts and to_ts as query params" do
      expect(connection).to receive(:get)
        .with(hash_including(params: hash_including("FromTs" => 1000, "ToTs" => 2000)))
        .and_return(response)

      described_class.all(counter_source: "Campaign", source_id: 1, from_ts: 1000, to_ts: 2000)
    end
  end
end
