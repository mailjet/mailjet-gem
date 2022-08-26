require "mailjet_spec_helper"

RSpec.describe Mailjet::Statistics_linkclick, :vcr do
  before { Mailjet.config.api_version = "v3" }

  it "returns link click statistics for a campaign" do
    statistics_link_click = Mailjet::Statistics_linkclick.all(campaign_id: 43810)
    expect(statistics_link_click.first.url).to eq('https://www.example.com')
  end
end
