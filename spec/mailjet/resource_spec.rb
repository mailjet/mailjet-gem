require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Mailjet::Resource do

  let(:resource_path) { "test" }
  let(:connection){ MiniTest::Mock.new }

  subject do
    class TestResource
      include Mailjet::Resource
      self.resource_path = "test"
    end
    TestResource.connection = connection
    TestResource
  end

  context "connection is not defined" do
    before(:each) do
      subject.connection = nil
    end

    describe ".connection" do
      it "returns a Mailjet::Connection referring to the \"test\" resource" do
        connection = subject.connection
        connection.must_be_instance_of Mailjet::Connection
        connection.url.must_match "#{Mailjet.config.end_point}/#{resource_path}"
      end
    end
  end

  context "connection is defined" do

    context "GET /test?Limit=1 returns '{\"Data\" : [{ \"Test\" : \"Value\" }]}'" do
      before(:each) do
        @response = '{"Data" : [{ "Test" : "Value" }]}'
        connection.expect :get, @response, [params: {limit: 1}]
      end

      describe ".first" do
        it "creates a new TestResource object" do
          instance = subject.first
          instance.must_be_instance_of TestResource
        end

        it "populates object with attributes returned by the API" do
          instance = subject.first
          instance.test.must_equal "Value"
        end
      end
    end

    context "GET /test returns '{\"Data\" : [{ \"Test1\" : \"Value1\", \"Test1\" : \"Value1\" }]}'" do
      before(:each) do
        @response = '{"Data" : [{ "Test" : "Value1" }, { "Test" : "Value2" }]}'
        connection.expect :get, @response, [params: {}]
      end

      describe ".all" do
        it "creates an array of TestResource objects" do
          instances = subject.all
          instances.each{ |instance| instance.must_be_instance_of TestResource }
        end

        it "populates objects with attributes returned by the API" do
          instances = subject.all
          instances[0].test.must_equal "Value1"
          instances[1].test.must_equal "Value2"
        end
      end
    end

    context "GET /test/id returns '{\"Data\" : [{ \"ID\" : 1, \"Test1\" : \"Value1\"}]}'" do
      before(:each) do
        @id = 1
        @response = "{\"Data\" : [{ \"ID\" : #{@id}, \"Test\" : \"Value1\" }]}"
        connection.expect :[], connection, [@id]
        connection.expect :get, @response
      end

      describe ".find(id)" do

        it "creates an array of TestResource objects" do
          instance = subject.find(@id)
        instance.must_be_instance_of TestResource
        end

        it "populates object with attributes returned by the API" do
          instance = subject.find(@id)
          instance.id.must_equal @id
          instance.test.must_equal "Value1"
        end
      end
    end
  end
end
