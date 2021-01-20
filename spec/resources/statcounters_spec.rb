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
  end
end
