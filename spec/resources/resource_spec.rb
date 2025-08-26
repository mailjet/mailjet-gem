require "mailjet_spec_helper"

RSpec.describe Mailjet::Resource, :vcr do
  context '/invalid_credentials' do
    it 'should raise api connection error' do
      call = Mailjet::Apikey.first
      expect{ call }.to_not be_nil
    end
  end

  context '/apikeytotals' do
    it 'should not be nil' do
      call = Mailjet::Apikeytotals.first
      expect(call).to_not be_nil
    end
  end

  context '/batchjob' do
    it 'should not be nil' do
      call = Mailjet::Batchjob.first
      expect(call).to_not be_nil
    end
  end

  context '/bouncestatistics' do
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

  context '/clickstatistics' do
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
    xit 'should not be nil' do
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

  context '/DATA/contactslist' do
    it 'should not be nil' do
      call =  Mailjet::ContactslistCsv.send_data(1, File.open('./spec/test.csv', 'r'))
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

  context '/listrecipientstatistics' do
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

  context '/message' do
    it 'should not be nil' do
      call = Mailjet::Message.first
      expect(call).to_not be_nil
    end
  end

  context '/messageinformation' do
    it 'should not be nil' do
      call = Mailjet::Messageinformation.first
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
      call = Mailjet::Newsletter_detailcontent.find(1)
      expect(call).to_not be_nil
    end
  end

  context '/newsletter/id/schedule' do
    it 'should not be nil' do
      call = Mailjet::Newsletter_schedule.find(1)
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
end
