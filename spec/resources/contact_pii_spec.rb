require "mailjet_spec_helper"

RSpec.describe Mailjet::ContactPii, :vcr do
  before { Mailjet.config.api_version = "v4" }

  describe ".delete" do
    it "removes existing contact by ID" do
      response = Mailjet::ContactPii.delete(4448421007)
      expect(response.status).to eq 200
      expect(response.body).to eq ''
    end

    it "return message for delete unexisting contact" do
      response = Mailjet::ContactPii.delete(123456)
      expect(response.status).to eq 200
      expect(response.body).to eq ''
    end
  end
end
