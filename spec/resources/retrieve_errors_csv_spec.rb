require "mailjet_spec_helper"

RSpec.describe Mailjet::RetrieveErrosCsv, :vcr do
  xit "returns id" do
    call =  Mailjet::RetrieveErrosCsv.find_by_id(1)
    expect(call).to eq nil
  end

  it "retruns error response" do
    expect { Mailjet::RetrieveErrosCsv.find_by_id(99999) }.to raise_error Mailjet::CommunicationError, /the server responded with status 404/
  end
end
