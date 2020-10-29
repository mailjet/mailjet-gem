require "mailjet_spec_helper"

RSpec.describe Mailjet::Contact_getcontactslists, :vcr do
  describe ".find" do
    it "returns all records" do
      list = Mailjet::Contact_getcontactslists.find(124409882)
      expect(list.count).to eq 2
    end

    it "returns nil when appropriate list not found" do
      list = Mailjet::Contact_getcontactslists.find(123)
      expect(list).to eq nil
    end

    it "returns collection when there is only one record" do
      list = Mailjet::Contact_getcontactslists.find(111)
      expect(list.count).to eq 1
    end
  end
end
