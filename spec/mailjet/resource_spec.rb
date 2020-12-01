require "mailjet_spec_helper"

RSpec.describe Mailjet::Resource do
  let(:connection) { double("Connection") }

  subject do
    class TestResource
      include Mailjet::Resource
      self.resource_path = "test"
    end

    TestResource.connection = connection

    TestResource
  end

  context "connection is not defined" do
    before do
      subject.connection = nil
    end

    describe ".connection" do
      it "returns a Mailjet::Connection referring to the 'test' resource" do
        connection = subject.connection

        expect(connection).to be_kind_of Mailjet::Connection
        expect(connection.url).to eq "https://api.mailjet.com/test"
      end
    end
  end

  describe ".first" do
    before  do
      allow(connection).to receive(:get).with(
        {
          :accept => :json,
          :accept_encoding => :deflate,
          :content_type => :json,
          :params => { "Limit" => 1 },
          :user_agent => "mailjet-api-v3-ruby/1.6.0"
        }
      ).and_return('{"Data" : [{ "Test" : "Value" }]}')
    end

    it "creates a new TestResource object" do
      instance = subject.first
      expect(instance).to be_kind_of TestResource
    end

    it "populates object with attributes returned by the API" do
      instance = subject.first
      expect(instance.test).to eq "Value"
    end
  end

  it ".first returns collection"

  describe ".all" do
    before  do
      allow(connection).to receive(:get).with(
        {
          :accept => :json,
          :accept_encoding => :deflate,
          :content_type => :json,
          :params => {},
          :user_agent => "mailjet-api-v3-ruby/1.6.0"
        }
      ).and_return('{"Data" : [{ "Test" : "Value1" }, { "Test" : "Value2" }]}')
    end

    it "creates an array of TestResource objects" do
      instances = subject.all
      expect(instances).to all(be_kind_of TestResource)
    end

    it "populates objects with attributes returned by the API" do
      instances = subject.all

      expect(instances[0].test).to eq "Value1"
      expect(instances[1].test).to eq "Value2"
    end
  end

  describe ".find" do
    before do
      allow(connection).to receive(:[]).with(id).and_return(connection)
      allow(connection).to receive(:get).with(
        {
          :accept => :json,
          :accept_encoding => :deflate,
          :content_type => :json,
          :user_agent => "mailjet-api-v3-ruby/1.6.0"
        }
      ).and_return("{\"Data\" : [{ \"ID\" : #{id}, \"Test\" : \"Value1\" }]}")
    end

    let(:id) { 1 }

    it "returns TestResource object" do
      instance = subject.find(id)
      expect(instance).to be_kind_of TestResource
    end

    it "populates object with attributes returned by the API" do
      instance = subject.find(id)

      expect(instance.id).to eq id
      expect(instance.test).to eq "Value1"
    end
  end
end
