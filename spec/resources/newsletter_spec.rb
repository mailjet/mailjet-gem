require "mailjet_spec_helper"

RSpec.describe Mailjet::Newsletter, :vcr do
  before { Mailjet.config.api_version = "v3" }

  it "returns valid newsletter" do
    newsletter = Mailjet::Newsletter.find(54218)
    expect(newsletter.segmentation_id).to eq 5329
  end

  it "updates :segmentation_id attribue" do
    newsletter = Mailjet::Newsletter.find(54218)
    newsletter.update_attributes(segmentation_id: 5330)
    newsletter = Mailjet::Newsletter.find(54218)

    expect(newsletter.segmentation_id).to eq 5330
  end
end
