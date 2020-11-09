require "mailjet_spec_helper"

describe "Mailjet API Resource" do
  subject do
    class Mailjet::Contactlist
      include Mailjet::Resource
      self.resource_path = "REST/contactslist"
      self.public_operations = [:get, :post, :put, :delete]
    end

    Mailjet::Contactlist
  end

  let(:subject_id) { 38778 }

  it "retrieves all contact lists", :vcr do
    lists = subject.all(limit: 0)
    expect(lists.size).to eq 2
  end

  xit "creates new contact lists", :vcr do
    list = subject.create(name: "Test List")
    expect(list.persisted?).to be_truthy
  end

  it "it retrieves lists by id", :vcr do
    list = subject.find(subject_id)
    expect(list.name).to eq "Test List"
  end

  xit "updates list fields", :vcr do
    list = subject.find(subject_id)
    list.update_attributes(name: "Test List Updated")

    list = subject.find(subject_id)
    expect(list.name).to eq "Test List Updated"
  end

  it "deletes list fields", :vcr do
    list = subject.find(subject_id)
    list.delete

    list = subject.find(subject_id)
    expect(list.is_deleted?).to be_truthy
  end

  context "the resource path does not exist" do
    before(:each) do
      subject.resource_path = "wrongresourcepath"
    end

    it "raises an error", :vcr do
      expect { subject.all(limit: 0) }.to raise_error Mailjet::ApiError
    end
  end

  context "API responds with non JSON content type" do
    require 'pry'

    before { Mailjet.config.api_version = "v3.1" }

    it "raises an error", :vcr do
      expect { subject.all }.to raise_error Mailjet::ApiError
    end
  end
end
