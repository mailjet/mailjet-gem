
require 'mailjet_spec_helper'

API_KEY = ENV['MJ_APIKEY_PUBLIC']
API_SECRET = ENV['MJ_APIKEY_PRIVATE']

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
      # should get every contact
      res = Mailjet::Contact.all(invalid: 0)
      expect(res[0].attributes['email']).not_to be_nil
    end

    it 'calls Contact.first' do
      res = Mailjet::Contact.first
      expect(res.attributes['email']).not_to be_nil
    end

    it 'calls Contact.find with numeric ID' do
      res = Mailjet::Contact.find(1)
      expect(res.attributes['email']).not_to be_nil
    end

    it 'calls Contact.find with Unique Key id' do
      expect {Mailjet::Contact.find('test@mailjet.com')}.not_to raise_error
    end

    it 'calls Contact.count' do
      res = Mailjet::Contact.count
      expect(res).not_to be_nil
    end

  end

  describe 'simple POST requests' do

    it 'calls Sender.create with no parameters' do
      expect {Mailjet::Sender.create()}.to raise_error
    end

    it 'calls Contactslist.managecontact with advanced properties' do
      res = Mailjet::Contactslist_managecontact.create(id: 34, email: 'test@mailjet.com', action: 'addnoforce')
      expect(res.class.resourceprop).to eq [:email, :name, :action, :properties]
    end

  end
=begin
  describe 'urls/call matcher' do

    [
      'https://api.mailjet.com/v3/REST/contact {}',
  		'https://api.mailjet.com/v3/REST/contact/2 {}',
  		'https://api.mailjet.com/v3/REST/contact/2 {}',
  		'https://api.mailjet.com/v3/REST/contact/3/getcontactslist {}',
  		'https://api.mailjet.com/v3/REST/contact/?countOnly=1 {}',
  		'https://api.mailjet.com/v3/REST/contact/?limit=2 {}',
  		'https://api.mailjet.com/v3/REST/contact/?offset=233 {}',
  		'https://api.mailjet.com/v3/REST/contact/?contatctList=34 {}',
  		'https://api.mailjet.com/v3/REST/contactslist/34/managecontact {"email":"test@mailjet.com"}',
  		'https://api.mailjet.com/v3/DATA/contactslist/34/csvdata "FILE"',
  		'https://api.mailjet.com/v3/REST/newsletter/?CountOnly=1 {}',
  		'https://api.mailjet.com/v3/DATA/batchjob/csverror {}',
  		'https://api.mailjet.com/v3/REST/contact {"email":"test@mailjet.com"}',
  		'https://api.mailjet.com/v3/send {"FromName":"name","FromEmail":"test@mailjet.com","Subject":"subject","Text-Part":"text","Recipients":[{"email":"test@mailjet.com"}]}',
  		'https://api.mailjet.com/v3/send {"FromName":"name","FromEmail":"test@mailjet.com","Subject":"subject","Text-Part":"text","Recipients":[{"email":"test@mailjet.com"},{"email":"test2@mailjet.com"}]}',
  		'https://api.mailjet.com/v3/send {"FromName":"name","FromEmail":"test@mailjet.com","Subject":"subject","Text-Part":"text","Recipients":[{"email":"test@mailjet.com","name":"name"},{"email":"test2@mailjet.com","name":"name"}]}',
  		'https://api.mailjet.com/v3/send {"FromName":"name","FromEmail":"test@mailjet.com","Subject":"subject","Text-Part":"text","Recipients":[{"email":"test@mailjet.com","vars":{"Key1":"Value1","Key2":"Value2"}}]}'
    ].each do |expected|
      p expected
    end
  end
=end
end
