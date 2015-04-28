require 'mailjet_spec_helper'

describe Mailjet do
  before(:all) do
     Mailjet.configure do |config|
        config.api_key = ENV['yourApiKey']
        config.secret_key = ENV['yourSecretKey']
        config.default_from = ENV['myRegisteredMailjetEmailAtDomainDotCom']
      end
  end

   context 'checks date format on API request' do
      it 'should NOT look like 2014-05-19T15:31:09Z' do
         date = Mailjet::Apikey.first.created_at
         expect(date).not_to match(/^(?:\d{4}-\d{2}-\d{2}|\d{4}-\d{1,2}-\d{1,2}[T \t]+\d{1,2}:\d{2}:\d{2}(\.[0-9]*)?(([ \t]*)Z|[-+]\d{2}?(:\d{2})?))$/)
      end
      it 'should look like 2014-05-19T15:31:09Z when converted to a string' do
         date = Mailjet::Apikey.first.created_at
         expect(date.to_s).to match(/^(?:\d{4}-\d{2}-\d{2}|\d{4}-\d{1,2}-\d{1,2}[T \t]+\d{1,2}:\d{2}:\d{2}(\.[0-9]*)?(([ \t]*)Z|[-+]\d{2}?(:\d{2})?))$/)
      end
      #needs to be changed
      it 'should look like -- Mon, 19 May 2014 15:31:09 +0000' do
         date = Mailjet::Apikey.first.created_at
         expect(date.is_a?(DateTime)).to match(true)
      end

  end

end
