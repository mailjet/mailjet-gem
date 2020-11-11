require "mailjet_spec_helper"

RSpec.describe Mailjet::Apikey do
  context "date format on API request", :vcr do
    it "is a kind of DateTime" do
      date = Mailjet::Apikey.first.created_at
      expect(date).to be_kind_of DateTime
    end

    it "matches 2014-05-19T15:31:09Z format when represented as String" do
      date = Mailjet::Apikey.first.created_at
      expect(date.to_s).to match(/^(?:\d{4}-\d{2}-\d{2}|\d{4}-\d{1,2}-\d{1,2}[T \t]+\d{1,2}:\d{2}:\d{2}(\.[0-9]*)?(([ \t]*)Z|[-+]\d{2}?(:\d{2})?))$/)
    end
  end
end
