require 'spec_helper'

describe "Mailjet API Resource" do

  subject do
    class Mailjet::Contactlist
      include Mailjet::Resource
      self.resource_path = "/v3/REST/contactslist"
      self.public_operations = [:get, :post, :put, :delete]
    end
    Mailjet::Contactlist
  end

  let(:subject_id) { 4 }

  it "retrieves all contact lists" do
    skip_if_no_config
    VCR.use_cassette('fetch lists') do
      lists = subject.all(limit: 0)
      lists.size.must_equal 9
    end
  end

  it "creates new contact lists" do
    skip_if_no_config
    VCR.use_cassette('create lists', match_requests_on: [:method, :uri, :body]) do
      list = subject.create(name: "Test List")
      list.must_be :persisted?
    end
  end

  it "it retrieves lists by id" do
    skip_if_no_config
    VCR.use_cassette('fetch list') do
      list = subject.find(subject_id)
      list.name.must_equal "Test List"
    end
  end

  it "updates list fields" do
    skip_if_no_config
    VCR.use_cassette('update list') do
      list = subject.find(subject_id)
      list.update_attributes(name: "Test List Updated")
      list = subject.find(subject_id)
      list.name.must_equal "Test List Updated"
    end
  end

  it "deletes list fields" do
    skip_if_no_config
    VCR.use_cassette('destroy list') do
      list = subject.find(subject_id)
      list.delete
      list = subject.find(subject_id)
      list.is_deleted?.must_equal true
    end
  end

  context "the resource path does not exist" do
    before(:each) do
      subject.resource_path = "wrongresourcepath"
    end

    it "raise an error" do
      skip_if_no_config
      VCR.use_cassette('fetch list on wrong resource path') do
        proc { subject.all(limit: 0) }.must_raise Mailjet::ApiError
      end
    end
  end
end
