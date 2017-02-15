require 'base64'
require 'mailjet'
require 'mailjet/mailer'

module Mailjet
  RSpec::Expectations.configuration.on_potential_false_positives = :nothing
  RSpec.describe APIMailer do
    it 'set proper fields also for multipart emails' do
      message = Mail.new

      fromName = 'Foobar'
      fromEmail = 'foobar@mailjet.com'
      to = ['foo@bar.com']
      text = 'hello'

      textPart = text_part = Mail::Part.new do
        body text
      end

      message.from = "#{fromName} <#{fromEmail}>"
      message.text_part = textPart
      message.to = to

      expect(Mailjet::Send).to receive(:create).with(
        hash_including(
          from_name: fromName,
          from_email: fromEmail,
          text_part: text
        )
      )

      APIMailer.new.deliver!(message)
    end

    it 'fallsback to default_from if from is not set' do
      Mailjet.config.default_from = 'Test Person <test@example.com>'

      message = Mail.new
      message.text_part = Mail::Part.new do
        body 'test'
      end

      message.to = ['foo@bar.com']

      expect(Mailjet::Send).to receive(:create).with(
        hash_including(
          from_name: 'Test Person',
          from_email: 'test@example.com',
          text_part: 'test'
        )
      )

      APIMailer.new.deliver!(message)
    end

    it 'does not overrwrite `from` with `default_from`' do
      Mailjet.config.default_from = 'Test Person <test@example.com>'

      message = Mail.new
      message.text_part = Mail::Part.new do
        body 'test'
      end

      message.to = ['foo@bar.com']
      message.from = 'FooBar <foobar@mailjet.com>'

      expect(Mailjet::Send).to receive(:create).with(
        hash_including(
          from_name: 'FooBar',
          from_email: 'foobar@mailjet.com',
          text_part: 'test'
        )
      )

      APIMailer.new.deliver!(message)
    end

    it 'test the cc prop' do
      from_name = 'John'
      from_email = 'john@bar.com'
      recipients = ['test@test.com', 'paul <paul@test.com>']
      ccR = 'blabla@test.com'

      message = Mail.new do
        from       "#{from_name} <#{from_email}>"
        to         recipients
        cc         ccR
      end

      expect(Mailjet::Send).to receive(:create).with(
        hash_including(
          from_name: from_name,
          from_email: from_email,
          to: recipients.join(', '),
          cc: 'blabla@test.com'
        )
      )

      APIMailer.new.deliver!(message)
    end

    it 'test with both text and html content' do
      from_name = 'John'
      from_email = 'john@bar.com'
      recipients = ['test@test.com', 'paul <paul@test.com>']
      text = 'Hi!'
      html = '<h1>Hello</h1>'

      message = Mail.new do
        from       "#{from_name} <#{from_email}>"
        to         recipients
      end

      message.text_part = Mail::Part.new do
        body text
      end

      message.html_part = Mail::Part.new do
        body html
      end

      expect(Mailjet::Send).to receive(:create).with(
        hash_including(
          text_part: text,
          html_part: html
        )
      )

      APIMailer.new.deliver!(message)
    end

    it 'test with names in recipients list' do
      from_name = 'John'
      from_email = 'john@bar.com'
      recipients = ['test@test.com', 'paul <paul@test.com>']

      message = Mail.new do
        from       "#{from_name} <#{from_email}>"
        to         recipients
      end

      message.header['X-ping'] = 'pong'
      message.header['ping'] = 'pong'
      message.header['template'] = 'pong'

      expect(Mailjet::Send).to receive(:create).with(
        hash_including(
          headers: { 'X-ping' => 'pong' }
        )
      )

      APIMailer.new.deliver!(message)
    end

    it 'test the reply_to prop' do
      from_name = 'Albert'
      from_email = 'albert@bar.com'
      recipients = ['test@test.com', 'paul <paul@test.com>']
      rt = 'john <john@test.com>'

      message = Mail.new do
        from       "#{from_name} <#{from_email}>"
        to         recipients
        reply_to   rt
      end

      expect(Mailjet::Send).to receive(:create).with(
        hash_including(
          reply_to: rt
        )
      )

      APIMailer.new.deliver!(message)
    end

    it 'test with one recipient' do
      from_name = 'Albert'
      from_email = 'albert@bar.com'
      recipients = 'test@test.com'

      message = Mail.new do
        from       "#{from_name} <#{from_email}>"
        to         recipients
      end

      expect(Mailjet::Send).to receive(:create).with(
        hash_including(
          to: recipients
        )
      )

      APIMailer.new.deliver!(message)
    end
    
    it 'test with one recipient on v3.1' do
      from_name = 'Albert'
      from_email = 'albert@bar.com'
      recipients = 'test <test@test.com>'

      message = Mail.new
      message.from = "#{from_name} <#{from_email}>"
      message.to = recipients

      expect(Mailjet::Send).to receive(:create).with(
        hash_including(
          :Messages=>[{:To=>[{:Email=>"test@test.com", :Name=>"test"}], :Sender=>nil, :Subject=>nil, :TextPart=>nil, :HTMLPart=>nil, :Headers=>{}, :From=>{:Email=>"albert@bar.com", :Name=>"Albert"}}]
        )
      )

      APIMailer.new(:'mj-trackclick' => true).deliver!(message, {"version"=> "v3.1", "call"=> false})
    end
    
    #it 'fails to send' do
    #  from_name = 'Albert'
    #  from_email = 'albert@bar.com'
    #  recipients = ''
    #  message = Mail.new do
    #    from       ""
    #    to         recipients
    #  end
      
    #  expect { raise NoMethodError }.to raise_error
    
    #  APIMailer.new.deliver!(message)
    #end

    it 'should test content id set on inline attachments' do
      from_name = 'Albert'
      from_email = 'albert@bar.com'
      recipients = 'test@test.com'
      
      message = Mail.new do
        from       "#{from_name} <#{from_email}>"
        to         recipients
      end
      
      content = 'FooBar'
      content_id = "FooBarId"
      file_name = "TestFileName"
      message.attachments.inline[file_name] = {
        mime_type: 'text/plain',
        content: content,
        content_id: content_id
      }

      expect(APIMailer.new.setContentV3_1(message)).to include(
        InlineAttachments: [{
          'ContentType' => 'text/plain',
          'Filename' => file_name,
          'Base64Content' => Base64.encode64(content),
          'ContentId' => content_id
        }]
      )
    end
  end
end
