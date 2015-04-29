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
      it 'should look like -- Mon, 19 May 2014 15:31:09 +0000' do
         date = Mailjet::Apikey.first.created_at
         expect(date.is_a?(DateTime)).to match(true)
      end
    end

    context '/apikey' do
      it 'should not be nil' do
        call = Mailjet::Apikey.first
        expect(call).to_not be_nil
      end
    end

    context '/apikeyacess' do
      it 'should not be nil' do
        call = Mailjet::Apikeyaccess.first
        expect(call).to_not be_nil
      end
    end

    context '/apikeytotals' do
      it 'should not be nil' do
        call = Mailjet::Apikeytotals.first
        expect(call).to_not be_nil
      end
    end

    context '/apitoken' do
      it 'should not be nil' do
        call = Mailjet::Apitoken.first
        expect(call).to_not be_nil
      end
    end

    context '/axtesting' do
      it 'should not be nil' do
        call = Mailjet::Axtesting.first
        expect(call).to_not be_nil
      end
    end

    context '/batchjob' do
      it 'should not be nil' do
        call = Mailjet::Batchjob.first
        expect(call).to_not be_nil
      end
    end

    context '/bouncestatistics' do #GET doesn't work
      it 'should not be nil' do
        call = Mailjet::Bouncestatistics.first
        expect(call).to_not be_nil
      end
    end

    context '/campaign' do
      it 'should not be nil' do
        call = Mailjet::Campaign.first
        expect(call).to_not be_nil
      end
    end

    context '/campaignstatistics' do
      it 'should not be nil' do
        call = Mailjet::Campaignstatistics.first
        expect(call).to_not be_nil
      end
    end

    context '/clickstatistics' do #GET doesn't work
      it 'should not be nil' do
        call = Mailjet::Clickstatistics.first
        expect(call).to_not be_nil
      end
    end

    context '/contact' do
      it 'should not be nil' do
        call = Mailjet::Contact.first
        expect(call).to_not be_nil
      end
    end

    context '/contactdata' do
      it 'should not be nil' do
        call = Mailjet::Contactdata.first
        expect(call).to_not be_nil
      end
    end

    context '/contactfilter' do
      it 'should not be nil' do
        call = Mailjet::Contactfilter.first
        expect(call).to_not be_nil
      end
    end

    context '/contacthistorydata' do
      it 'should not be nil' do
        call = Mailjet::Contacthistorydata.first
        expect(call).to_not be_nil
      end
    end

    context '/contactmetadata' do
      it 'should not be nil' do
        call = Mailjet::Contactmetadata.first
        expect(call).to_not be_nil
      end
    end

    context '/contactslist' do
      it 'should not be nil' do
        call = Mailjet::Contactslist.first
        expect(call).to_not be_nil
      end
    end

    context '/contactslistsignup' do
      it 'should not be nil' do
        call = Mailjet::Contactslistsignup.first
        expect(call).to_not be_nil
      end
    end

    context '/contactstatistics' do
      it 'should not be nil' do
        call = Mailjet::Contactstatistics.first
        expect(call).to_not be_nil
      end
    end

    context '/csvimport' do
      it 'should not be nil' do
        call = Mailjet::Csvimport.first
        expect(call).to_not be_nil
      end
    end

    context '/domainstatistics' do
      it 'should not be nil' do
        call = Mailjet::Domainstatistics.first
        expect(call).to_not be_nil
      end
    end

    context '/eventcallbackurl' do
      it 'should not be nil' do
        call = Mailjet::Eventcallbackurl.first
        expect(call).to_not be_nil
      end
    end

    context '/geostatistics' do
      it 'should not be nil' do
        call = Mailjet::Geostatistics.first
        expect(call).to_not be_nil
      end
    end

    context '/graphstatistics' do
      it 'should not be nil' do
        call = Mailjet::Graphstatistics.first
        expect(call).to_not be_nil
      end
    end

    context '/listrecipient' do
      it 'should not be nil' do
        call = Mailjet::Listrecipient.first
        expect(call).to_not be_nil
      end
    end

    context '/listrecipient' do
      it 'should not be nil' do
        call = Mailjet::Listrecipientstatistics.first
        expect(call).to_not be_nil
      end
    end

    context '/liststatistics' do
      it 'should not be nil' do
        call = Mailjet::Liststatistics.first
        expect(call).to_not be_nil
      end
    end

    context '/manycontacts' do
      it 'should not be nil' do
        call = Mailjet::Manycontacts.first
        expect(call).to_not be_nil
      end
    end

    context '/message' do
      it 'should not be nil' do
        call = Mailjet::Message.first
        expect(call).to_not be_nil
      end
    end


    context '/messagehistory' do
      it 'should not be nil' do
        call = Mailjet::Messagehistory.first
        expect(call).to_not be_nil
      end
    end

    context '/messageinformation' do
      it 'should not be nil' do
        call = Mailjet::Messageinformation.first
        expect(call).to_not be_nil
      end
    end

    context '/messagesentstatistics' do
      it 'should not be nil' do
        call = Mailjet::Messagesentstatistics.first
        expect(call).to_not be_nil
      end
    end

    context '/messagestate' do
      it 'should not be nil' do
        call = Mailjet::Messagestate.first
        expect(call).to_not be_nil
      end
    end

    context '/messagestatistics' do
      it 'should not be nil' do
        call = Mailjet::Messagestatistics.first
        expect(call).to_not be_nil
      end
    end

    context '/metadata' do
      it 'should not be nil' do
        call = Mailjet::Metadata.first
        expect(call).to_not be_nil
      end
    end

    context '/myprofile' do
      it 'should not be nil' do
        call = Mailjet::Myprofile.first
        expect(call).to_not be_nil
      end
    end

    context '/newsletter' do
      it 'should not be nil' do
        call = Mailjet::Newsletter.first
        expect(call).to_not be_nil
      end
    end

    context '/newsletter/id/detailcontent' do
      it 'should not be nil' do
        call = Mailjet::Newsletter_detailcontent.first
        expect(call).to_not be_nil
      end
    end

    context '/newsletter/id/schedule' do
      it 'should not be nil' do
        call = Mailjet::Newsletter_schedule.first
        expect(call).to_not be_nil
      end
    end

    context '/newsletter/id/send' do
      it 'should not be nil' do
        call = Mailjet::Newsletter_send.first
        expect(call).to_not be_nil
      end
    end

    context '/newsletter/id/test' do
      it 'should not be nil' do
        call = Mailjet::Newsletter_test.first
        expect(call).to_not be_nil
      end
    end

    context '/newsletterblock' do
      it 'should not be nil' do
        call = Mailjet::Newsletterblock.first
        expect(call).to_not be_nil
      end
    end

    context '/newsletterproperties' do
      it 'should not be nil' do
        call = Mailjet::Newsletterproperties.first
        expect(call).to_not be_nil
      end
    end

    context '/newslettertemplate' do
      it 'should not be nil' do
        call = Mailjet::Newslettertemplate.first
        expect(call).to_not be_nil
      end
    end

    context '/newslettertemplateblock' do
      it 'should not be nil' do
        call = Mailjet::Newslettertemplateblock.first
        expect(call).to_not be_nil
      end
    end

    context '/newslettertemplatecategory' do
      it 'should not be nil' do
        call = Mailjet::Newslettertemplatecategory.first
        expect(call).to_not be_nil
      end
    end

    context '/newslettertemplateproperties' do
      it 'should not be nil' do
        call = Mailjet::Newslettertemplateproperties.first
        expect(call).to_not be_nil
      end
    end

    context '/openinformation' do
      it 'should not be nil' do
        call = Mailjet::Openinformation.first
        expect(call).to_not be_nil
      end
    end

    context '/openstatistics' do
      it 'should not be nil' do
        call = Mailjet::Openstatistics.first
        expect(call).to_not be_nil
      end
    end

    context '/parseroute' do
      it 'should not be nil' do
        call = Mailjet::Parseroute.first
        expect(call).to_not be_nil
      end
    end

    context '/preferences' do
      it 'should not be nil' do
        call = Mailjet::Preferences.first
        expect(call).to_not be_nil
      end
    end

    context '/sender' do
      it 'should not be nil' do
        call = Mailjet::Sender.first
        expect(call).to_not be_nil
      end
    end

    context '/senderstatistics' do
      it 'should not be nil' do
        call = Mailjet::Senderstatistics.first
        expect(call).to_not be_nil
      end
    end

    context '/toplinkclicked' do
      it 'should not be nil' do
        call = Mailjet::Toplinkclicked.first
        expect(call).to_not be_nil
      end
    end

    context '/trigger' do
      it 'should not be nil' do
        call = Mailjet::Trigger.first
        expect(call).to_not be_nil
      end
    end

    context '/user' do
      it 'should not be nil' do
        call = Mailjet::User.first
        expect(call).to_not be_nil
      end
    end

    context '/useragentstatistics' do
      it 'should not be nil' do
        call = Mailjet::Useragentstatistics.first
        expect(call).to_not be_nil
      end
    end

    context '/widget' do
      it 'should not be nil' do
        call = Mailjet::Widget.first
        expect(call).to_not be_nil
      end
    end

    context '/widgetcustomvalue' do
      it 'should not be nil' do
        call = Mailjet::Widgetcustomvalue.first
        expect(call).to_not be_nil
      end
    end



end
