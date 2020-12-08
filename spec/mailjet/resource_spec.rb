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

  describe ".define_options" do
    it "returns default values" do
      options = subject.define_options

      expect(options).to eq ({
        perform_api_call: true,
        url: "https://api.mailjet.com",
        version: "v3"
      })
    end

    it "overrides default options" do
      options = subject.define_options({
        "url" => "fake.host",
        version: "v0",
        "perform_api_call" => false
      })

      expect(options).to eq ({
        perform_api_call: false,
        url: "fake.host",
        version: "v0"
      })
    end

    it "filters out unpermitted options" do
      options = subject.define_options({
        "invalid_option" => "value",
        "version" => "v0",
      })

      expect(options).to eq ({
        perform_api_call: true,
        url: "https://api.mailjet.com",
        version: "v0"
      })
    end
  end

  describe ".camelcase_keys" do
    it "converts keys to camel case" do
      input = {
        "text_part" => "value1",
        "html_part" => "value2",
        "inline_attachments" => "value3",
        "other_key" => "value4"
      }

      normalized = subject.camelcase_keys(input)

      expect(normalized).to eq ({
        "Text-part" => "value1",
        "Html-part" => "value2",
        "Inline_attachments" => "value3",
        "OtherKey" => "value4"
      })
    end
  end

  describe ".underscore_keys" do
    it "converts keys to snake case" do
      input = {
        "text_part" => "value1",
        "html_part" => "value2",
        "inline_attachments" => "value3",
        "OtherKey" => "value4"
      }

      normalized = subject.underscore_keys(input)

      expect(normalized).to eq ({
        "Text-part" => "value1",
        "Html-part" => "value2",
        "Inline_attachments" => "value3",
        "other_key" => "value4"
      })
    end
  end

  describe ".format_params" do
    it "converts attributes to CamelCase" do
      params = subject.format_params({
        test: "value"
      })

      expect(params).to eq({
        "Test" => "value"
      })
    end

    it "formats sort attribute" do
      params = subject.format_params({
        attr: "value1",
        other_attr: "value2",
        sort: { attr: "acs", other_attr: "desc" }
      })

      expect(params).to eq({
        "Attr" => "value1",
        "OtherAttr" => "value2",
        "Sort" => "Attr ACS, OtherAttr DESC"
      })
    end
  end
end
