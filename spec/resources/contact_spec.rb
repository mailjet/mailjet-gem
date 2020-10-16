require "mailjet_spec_helper"

RSpec.describe "Mailjet::Contact", :vcr do
  it "returns all contacts" do
    contacts = Mailjet::Contact.all()
    expect(contacts.count).to eq 4
  end

  it "returns specified amount of contacts" do
    contacts = Mailjet::Contact.all(limit: 2)
    expect(contacts.count).to eq 2
  end

  it "returns all contacts when parameters invalid" do
    contacts = Mailjet::Contact.all(invalid_parameter: 0)
    expect(contacts.count).to eq 4
  end

  it "returns first contact" do
    contact = Mailjet::Contact.first
    expect(contact.attributes["email"]).to eq "passenger1@example.com"
  end

  it "finds contact by ID" do
    contact = Mailjet::Contact.find(124409882)
    expect(contact.attributes["email"]).to eq "passenger1@example.com"
  end

  it "finds contact by email" do
    contact = Mailjet::Contact.find("passenger1@example.com")
    expect(contact.attributes["email"]).to eq "passenger1@example.com"
  end

  it "returns nil when contact not found" do
    contact = Mailjet::Contact.find("unknown@example.com")
    expect(contact).to be_nil
  end

  xit "returns total amount of contacts" do
    amount = Mailjet::Contact.count
    expect(amount).to eq 4
  end
end
