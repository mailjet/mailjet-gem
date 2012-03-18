# encoding: utf-8

require 'minitest_helper'

describe Mailjet::ApiRequest do

  describe "#request_path" do
    it "should return the path of the method" do
      Mailjet::ApiRequest.new('method_name').send(:request_path).must_equal '/0.1/methodName?output=json'
    end

    it "should respect api_version" do
      Mailjet.config.expects(:api_version).returns(0.2)
      Mailjet::ApiRequest.new('method_name').send(:request_path).must_equal '/0.2/methodName?output=json'
    end
  end

  describe "#request_port" do
    it "should return 80 if use_https is false" do
      Mailjet.config.use_https = false
      Mailjet::ApiRequest.new('method_name').send(:request_port).must_equal 80
    end

    it "should return 443 if use_https is true" do
      Mailjet.config.use_https = true
      Mailjet::ApiRequest.new('method_name').send(:request_port).must_equal 443
    end
  end

  describe "#request" do
    it "should return an Http request" do
      request = Mailjet::ApiRequest.new('method_name', {}, 'Post')
      request.send(:request).must_be_kind_of(Net::HTTP::Post)

      request = Mailjet::ApiRequest.new('method_name', {}, 'Get')
      request.send(:request).must_be_kind_of(Net::HTTP::Get)
    end
  end

  describe "#response" do
    it "should raise an ApiError if authentication fails" do
      request = Mailjet::ApiRequest.new('method_name', {}, 'Get')
      lambda { 
        request.response
      }.must_raise(Mailjet::ApiError)
    end

    it "should return a Hash with response values if request is ok" do
      request = Mailjet::ApiRequest.new('user_infos', {}, 'Get')
      response = request.response
      response.must_be_kind_of(Hash)
      response['infos']['username'].must_equal 'benoit.benezech@gmail.com'
    end
  end

  describe "#guess_request_type" do
    it "should return 'Post' if method_name contains a special verb" do
      Mailjet::ApiRequest.new('lists_add_contact').send(:guess_request_type).must_equal 'Post'
      Mailjet::ApiRequest.new('lists_create').send(:guess_request_type).must_equal 'Post'
      Mailjet::ApiRequest.new('lists_delete').send(:guess_request_type).must_equal 'Post'
      Mailjet::ApiRequest.new('lists_remove_contact').send(:guess_request_type).must_equal 'Post'
      Mailjet::ApiRequest.new('lists_update').send(:guess_request_type).must_equal 'Post'
    end

    it "should return 'Get' if method_name does not contain a verb" do
      Mailjet::ApiRequest.new('key_list').send(:guess_request_type).must_equal 'Get'
      Mailjet::ApiRequest.new('contact_list').send(:guess_request_type).must_equal 'Get'
      Mailjet::ApiRequest.new('lists_all').send(:guess_request_type).must_equal 'Get'
      Mailjet::ApiRequest.new('lists_email').send(:guess_request_type).must_equal 'Get'
    end
  end
end