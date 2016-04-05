
require 'mailjet_spec_helper'

API_KEY = ENV['MJ_APIKEY_PUBLIC']
API_SECRET = ENV['MJ_APIKEY_PRIVATE']
random_email = (0...8).map { (65 + rand(26)).chr }.join + '@test.com'

describe Mailjet do
  before(:all) do

    Mailjet.configure do |config|
      config.api_key = API_KEY
      config.secret_key = API_SECRET
    end
  end

  describe 'simple GET requests' do
    it 'calls Contact.all without parameters' do
      res = Mailjet::Contact.all()
      expect(res).not_to be_nil
    end

    it 'calls Contact.all with valid parameters' do
      res = Mailjet::Contact.all(limit: 2)
      expect(res[0].attributes['email']).not_to be_nil
    end

    it 'calls Contact.all with invalid parameters' do
      res = Mailjet::Contact.all(invalid: 0)
      expect(res[0].attributes['email']).not_to be_nil
    end

    it 'calls Contact.first' do
      res = Mailjet::Contact.first
      expect(res.attributes['email']).not_to be_nil
    end

    it 'calls Contact.find with numeric ID' do
      res = Mailjet::Contact.find(5771382)
      expect(res.attributes['email']).not_to be_nil
    end

    it 'calls Contact.find with Unique Key id' do
      expect do
        Mailjet::Contact.find('test@mailjet.com')
      end.not_to raise_error
    end

    it 'calls Contact.count' do
      res = Mailjet::Contact.count
      expect(res).not_to be_nil
    end

  end

  describe 'Simple SEND request' do
    it 'sends a basic email' do
      res = Mailjet::Send.create(
        :from_email => 'gbadi@mailjet.com',
        :from_name => 'gbadimailjetcom',
        :subject => 'Travis Ruby',
        :recipients => [ { 'Email' => 'gbadi@mailjet.com' } ],
        :text_part => 'Message' )
      expect(res).not_to be_nil
    end

    it 'sends a basic email to 2 recipients' do
      res = Mailjet::Send.create(
        :from_email => 'gbadi@mailjet.com',
        :from_name => 'gbadimailjetcom',
        :subject => 'Travis Ruby',
        :recipients => [ { 'Email' => 'gbadi@mailjet.com' }, { 'Email' => 'gbadi@mailjet.com' } ],
        :text_part => 'Message two 2 people' )
      expect(res).not_to be_nil
    end

    it 'sends a basic email to 2 recipients as messages' do
      res = Mailjet::Send.create(
        :messages => [{
          'FromEmail' => 'gbadi@mailjet.com',
          'FromName' => 'gbadimailjetcom',
          'Subject' => 'Travis Ruby',
          'Recipients' => [ { 'Email' => 'gbadi@mailjet.com' } ],
          'Text-Part' => 'Messages prop'
        }, {
          'FromEmail' => 'gbadi@mailjet.com',
          'FromName' => 'gbadimailjetcom',
          'Subject' => 'Travis Ruby',
          'Recipients' => [ { 'Email' => 'gbadi@mailjet.com' } ],
          'Text-Part' => 'Messages prop'
        }])
      expect(res).not_to be_nil
    end
  end

  describe 'Simple POST on Contact' do
    it 'Creates a random Contact' do
      res = Mailjet::Contact.create(email: random_email, name: 'Test email')
      expect(res).not_to be_nil
    end
  end

  describe 'PUT contact' do
    it 'Should update the contact name' do
      res = Mailjet::Contact.find(random_email)
      res.name = 'Updated name'
      response = res.save!
      expect(response).not_to be_nil
    end
  end

end
