require "mailjet_spec_helper"

RSpec.describe Mailjet::Resource do
  before { Mailjet.config.api_version = "v3" }

  let(:connection) { instance_double("Connection") }
  let(:adapter) { instance_double(Faraday::Response, body: "") }

  subject do
    class TestResource
      include Mailjet::Resource
      self.resource_path = "REST/test"
    end

    TestResource.connection = connection

    TestResource
  end

  context "connection is not defined" do
    before { subject.connection = nil }

    describe ".connection" do
      xit "returns a Mailjet::Connection referring to the 'test' resource" do
        connection = subject.connection

        expect(connection).to be_kind_of Mailjet::Connection
        expect(connection.url).to eq "https://api.mailjet.com/REST/test"
      end
    end
  end

  describe ".first" do
    before  do
      allow(adapter).to receive(:body).and_return("{ \"Count\" : 1, \"Data\" : [{ \"Test\" : \"Value\" }], \"Total\" : 1 }")
      allow(connection).to receive(:get).with(
        {
          "Accept"=>"application/json",
          "Accept-Encoding"=>"deflate",
          "Content-Type"=>"application/json",
          :params => { "Limit" => 1 },
          "User-Agent" => "mailjet-api-v3-ruby/#{Mailjet::VERSION}"
        }
      ).and_return(adapter)
    end

    it "creates a new TestResource object" do
      instance = subject.first
      expect(instance).to be_kind_of TestResource
    end

    it "populates object with attributes returned by the API" do
      instance = subject.first
      expect(instance.test).to eq "Value"
    end

    context 'when response is 400' do
      let(:params) { { "Limit" => 1 } }
      let(:api_error) do
        Mailjet::ApiError.new(
          '400',
          'body',
          connection,
          "REST/test",
          params
        )
      end
      before do
        allow(connection).to receive(:get).with(
          {
            "Accept"=>"application/json",
            "Accept-Encoding"=>"deflate",
            "Content-Type"=>"application/json",
            :params => params,
            "User-Agent" => "mailjet-api-v3-ruby/#{Mailjet::VERSION}"
          }
        ).and_raise(api_error)
      end

      it 'reraises api error with expected message' do
        subject.first
      rescue Mailjet::ApiError => err
        expect(err.message).to include('error 400 while sending')
      else
        fail
      end
    end
  end

  describe ".all" do
    before  do
      allow(adapter).to receive(:body).and_return("{ \"Count\" : 1, \"Data\" : [{ \"Test\" : \"Value1\" }, { \"Test\" : \"Value2\" }], \"Total\" : 1 }")
      allow(connection).to receive(:get).with(
        {
          "Accept"=>"application/json",
          "Accept-Encoding"=>"deflate",
          "Content-Type"=>"application/json",
          :params => {},
          "User-Agent" => "mailjet-api-v3-ruby/#{Mailjet::VERSION}"
        }
      ).and_return(adapter)
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

    context 'when response is 400' do
      let(:params) { {} }
      let(:api_error) do
        Mailjet::ApiError.new(
          '400',
          'body',
          connection,
          "REST/test",
          params
        )
      end
      before do
        allow(connection).to receive(:get).with(
          {
            "Accept"=>"application/json",
            "Accept-Encoding"=>"deflate",
            "Content-Type"=>"application/json",
            :params => {},
            "User-Agent" => "mailjet-api-v3-ruby/#{Mailjet::VERSION}"
          }
        ).and_raise(api_error)
      end

      it 'reraises api error with expected message' do
        subject.all
      rescue Mailjet::ApiError => err
        expect(err.message).to include('error 400 while sending')
      else
        fail
      end
    end
  end

  describe ".find" do
    before do
      allow(adapter).to receive(:body).and_return("{\"Data\" : [{ \"ID\" : #{id}, \"Test\" : \"Value1\" }]}")
      allow(connection).to receive(:[]).with(id).and_return(connection)
      allow(connection).to receive(:get).with(
        {
          "Accept"=>"application/json",
          "Accept-Encoding"=>"deflate",
          "Content-Type"=>"application/json",
          "User-Agent" => "mailjet-api-v3-ruby/#{Mailjet::VERSION}"
        }
      ).and_return(adapter)
    end

    let(:id) { 1 }

    it "returns TestResource object" do
      instance = subject.find(id)
      expect(instance).to be_kind_of TestResource
    end

    it "populates object with attributes returned by the API" do
      instance = subject.find(id)

      expect(instance.id).to eq id.to_i
      expect(instance.test).to eq "Value1"
    end

    context 'when response is 400' do
      let(:params) { {} }
      let(:api_error) do
        Mailjet::ApiError.new(
          '400',
          'body',
          connection,
          "REST/test",
          params
        )
      end
      before do
        allow(connection).to receive(:[]).with(id).and_return(connection)
        allow(connection).to receive(:get).with(
          {
            "Accept"=>"application/json",
            "Accept-Encoding"=>"deflate",
            "Content-Type"=>"application/json",
            "User-Agent" => "mailjet-api-v3-ruby/#{Mailjet::VERSION}"
          }
        ).and_raise(api_error)
      end

      it 'reraises api error with expected message' do
        subject.find(id)
      rescue Mailjet::ApiError => err
        expect(err.message).to include('error 400 while sending')
      else
        fail
      end
    end
  end

  describe '.delete' do
    let(:id) { 1 }
    let(:respond_data) { "{\"Data\" : [{ \"ID\" : #{id}, \"Test\" : \"Value1\" }]}" }
    let(:delete_response) do
      instance_double(Faraday::Response,
        status: 204
      )
    end

    before do
      allow(adapter).to receive(:body).and_return(respond_data)
      allow(connection).to receive(:[]).with(id).and_return(connection)
      allow(connection).to receive(:get).with(
        {
          "Accept"=>"application/json",
          "Accept-Encoding"=>"deflate",
          "Content-Type"=>"application/json",
          "User-Agent" => "mailjet-api-v3-ruby/#{Mailjet::VERSION}"
        }
      ).and_return(adapter)
      allow(connection).to receive(:delete).with(
        {
          "Accept"=>"application/json",
          "Accept-Encoding"=>"deflate",
          "Content-Type"=>"application/json",
          "User-Agent" => "mailjet-api-v3-ruby/#{Mailjet::VERSION}"
        }
      ).and_return(delete_response)
    end

    it "returns 204 response" do
      resource = subject.find(id)
      response = resource.delete
      expect(response.status).to eq(204)
    end

    context 'when response is 400' do
      let(:params) { {} }
      let(:api_error) do
        Mailjet::ApiError.new(
          '400',
          'body',
          connection,
          "REST/test",
          params
        )
      end
      before do
        allow(adapter).to receive(:body).and_return(respond_data)
        allow(connection).to receive(:[]).with("#{id}").and_return(connection)
        allow(connection).to receive(:get).with(
          {
            "Accept"=>"application/json",
            "Accept-Encoding"=>"deflate",
            "Content-Type"=>"application/json",
            "User-Agent" => "mailjet-api-v3-ruby/#{Mailjet::VERSION}"
          }
        ).and_return(adapter)
        allow(connection).to receive(:delete).with(
          {
            "Accept"=>"application/json",
            "Accept-Encoding"=>"deflate",
            "Content-Type"=>"application/json",
            "User-Agent" => "mailjet-api-v3-ruby/#{Mailjet::VERSION}"
          }
        ).and_raise(api_error)
      end

      it 'reraises api error with expected message' do
        resource = subject.find(id)
        response = resource.delete
      rescue Mailjet::ApiError => err
        expect(err.message).to include('error 400 while sending')
      else
        fail
      end
    end
  end

  describe "#save" do
    subject do
      class TestContact
        include Mailjet::Resource
        self.resource_path = 'REST/contact'
        self.public_operations = [:get, :put, :post]
        self.filters = [:campaign, :contacts_list, :is_unsubscribed, :last_activity_at, :recipient, :status]
        self.resourceprop = [:created_at, :delivered_count, :email, :id, :is_opt_in_pending, :is_spam_complaining, :last_activity_at, :last_update_at, :name, :unsubscribed_at, :unsubscribed_by]
      end

      TestContact
    end

    it "updates resource" do
      VCR.use_cassette("resource/test_contact/update") do
        c = subject.new("is_active" => true, "id" => 123)

        contact = subject.find(196009940)
        allow(subject).to receive(:default_connection).and_call_original

        contact.name = "Joe Doe"
        res = contact.save

        expect(subject).to have_received(:default_connection)
          .with({
            perform_api_call: true,
            url: "https://api.mailjet.com",
            version: "v3"
          })
        expect(contact.attributes).to eq ({
          "created_at" => "Thu, 10 Dec 2020 17:35:35 +0000",
          "delivered_count" => 0,
          "email" => "save_resource_test@example.com",
          "exclusion_from_campaigns_updated_at" => "Thu, 10 Dec 2020 17:35:35 +0000",
          "id" => 196009940,
          "is_excluded_from_campaigns" => true,
          "is_opt_in_pending" => false,
          "is_spam_complaining" => false,
          "last_activity_at" => "",
          "last_update_at" => "",
          "name" => "Joe Doe",
          "persisted" => true,
          "unsubscribed_at" => "",
          "unsubscribed_by" => "",
        })
        expect(res).to eq true
      end
    end

    it "creates resource" do
      VCR.use_cassette("resource/test_contact/create") do
        allow(subject).to receive(:default_connection).and_call_original

        contact = subject.new(
          name: "Create Resource",
          email: "create_resource_test@example.com"
        )
        allow(contact).to receive(:parse_api_json).and_call_original

        res = contact.save

        expect(subject).to have_received(:default_connection)
          .with({
            perform_api_call: true,
            url: "https://api.mailjet.com",
            version: "v3"
          })
        expect(contact).to have_received(:parse_api_json)
        expect(contact.attributes).to eq ({
          "created_at" => "Fri, 11 Dec 2020 00:59:48 +0000",
          "delivered_count" => 0,
          "email" => "create_resource_test@example.com",
          "exclusion_from_campaigns_updated_at" => "",
          "id" => 196355328,
          "is_excluded_from_campaigns" => false,
          "is_opt_in_pending" => false,
          "is_spam_complaining" => false,
          "last_activity_at" => "",
          "last_update_at" => "",
          "name" => "Create Resource",
          "persisted" => false,
          "unsubscribed_at" => "",
          "unsubscribed_by" => "",
        })
        expect(res).to eq true
      end
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

  describe ".parse_api_json" do
    let(:raw_json) {
      '{ "Count" : 1, "Data" : [{ "ACL" : "", "APIKey" : "qwerty123", "CreatedAt"
      : "2020-09-16T10:33:54Z", "ID" : 1404561, "IsActive" : true, "IsMaster" :
      true, "Name" : "user", "QuarantineValue" : 0, "RegionID" : 0, "Runlevel" :
      "Normal", "SecretKey" : "qwerty123", "Skipspamd" : 1, "TrackHost" : "xkw6j.mjt.lu",
      "UserID" : 1389226 }], "Total" : 1 }'
    }

    it "parses string json to hash" do
      hash = subject.parse_api_json(raw_json)

      expect(hash).to eq(
        [{
          "acl"=>"",
          "api_key"=>"qwerty123",
          "created_at"=>"Wed, 16 Sep 2020 10:33:54 +0000",
          "id"=>1404561,
          "is_active"=>true,
          "is_master"=>true,
          "name"=>"user",
          "quarantine_value"=>0,
          "region_id"=>0,
          "runlevel"=>"Normal",
          "secret_key"=>"qwerty123",
          "skipspamd"=>1,
          "track_host"=>"xkw6j.mjt.lu",
          "user_id"=>1389226
        }]
      )
    end
  end

  describe ".create_action_resource_path" do
    it "returns url with resource ID" do
      url = subject.create_action_resource_path(1)
      expect(url).to eq "REST/test/1"
    end

    it "returns url with resource ID and job ID" do
      url = subject.create_action_resource_path(1, 2)
      expect(url).to eq "REST/test/1/2"
    end

    it "returns url with job ID when path already contains ID" do
      subject.resource_path = "REST/test/123"

      url = subject.create_action_resource_path(1, 2)

      expect(url).to eq "REST/test/1/2"
    end

    it "returns url with resource ID when path already contains ID" do
      subject.resource_path = "REST/test/123"

      url = subject.create_action_resource_path(1)

      expect(url).to eq "REST/test/1"
    end

    it "returns url with job ID when path already contains ID" do
      subject.resource_path = "REST/test/123"

      url = subject.create_action_resource_path(1, 2)

      expect(url).to eq "REST/test/1/2"
    end

    context "path contacts and action managemanycontacts" do
      before do
        subject.resource_path = "REST/contacts"
        subject.action = "managemanycontacts"
      end

      it "returns url without" do
        url = subject.create_action_resource_path(1)
        expect(url).to eq "REST/contacts"
      end

      it "returns url with job ID" do
        url = subject.create_action_resource_path(1, 2)
        expect(url).to eq "REST/contacts/2"
      end

      it "returns url with job ID when path already contains ID" do
        subject.resource_path = "REST/contacts/123"

        url = subject.create_action_resource_path(1, 2)

        expect(url).to eq "REST/contacts/2"
      end

      it "returns url without resource ID when path already contains ID" do
        subject.resource_path = "REST/contacts/123"

        url = subject.create_action_resource_path(1)

        expect(url).to eq "REST/contacts"
      end

      it "returns url with job ID when path already contains ID" do
        subject.resource_path = "REST/contacts/123"

        url = subject.create_action_resource_path(1, 2)

        expect(url).to eq "REST/contacts/2"
      end
    end
  end

  describe ".convert_dates_from" do
    test_table = [
      ["2020-09-16T10:33:54Z", "Wed, 16 Sep 2020 10:33:54 +0000"],
      [nil, nil],
      [
        ["2020-09-16T10:33:54Z", "2020-09-16T10:35:28Z"],
        ["Wed, 16 Sep 2020 10:33:54 +0000", "Wed, 16 Sep 2020 10:35:28 +0000"]
      ],
      [
        { attr: "2020-09-16T10:33:54Z" },
        { attr: "Wed, 16 Sep 2020 10:33:54 +0000" },
      ],
      [
        { root: { nested: "2020-09-16T10:33:54Z" }},
        { root: { nested: "Wed, 16 Sep 2020 10:33:54 +0000" }},
      ],
      ["invalid date", "invalid date"]
    ]

    test_table.each_with_index do |t, i|
      it "converts ##{i}" do
        converted = subject.convert_dates_from(t.first)
        expect(converted).to eq t.last
      end
    end
  end
end
