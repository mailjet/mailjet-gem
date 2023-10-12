require "mailjet_spec_helper"

RSpec.describe Mailjet::ContactslistCsv, :vcr do
  it "returns id" do
    call =  Mailjet::ContactslistCsv.send_data(1, File.open('./spec/test.csv', 'r'))
    expect(call).to eq 2
  end

  it "retruns error response" do
    call =  Mailjet::ContactslistCsv.send_data('invalid_id', File.open('./spec/test.csv', 'r'))
    expect(call).to eq({"ErrorInfo"=>"", "ErrorMessage"=>"Source object not found", "StatusCode"=>404})
  end
end
