require "mailjet_spec_helper"

RSpec.describe Mailjet::Messagehistory, :vcr do
  describe ".find" do
    it "returns all records" do
      history = Mailjet::Messagehistory.find(576460757221292748)
      expect(history.count).to eq 6
    end

    it "returns collection when there is only one record" do
      history = Mailjet::Messagehistory.find(288230381068036023)
      puts history.first.attributes
      expect(history.count).to eq 1
    end
  end
end
