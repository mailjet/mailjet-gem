require 'base64'
require 'mailjet'
require 'mailjet/mailer'
require 'mailjet_spec_helper'

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
        ), {}
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
        ), {}
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
        ), {}
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
        ), {}
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
        ), {}
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
        ), {}
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
        ), {}
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
        ), {}
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
          :Messages=>[{:To=>[{:Email=>"test@test.com", :Name=>"test"}], :Headers=>{}, :From=>{:Email=>"albert@bar.com", :Name=>"Albert"}}]
        ),
        { "version" => "v3.1" }
      )

      APIMailer.new.deliver!(message, { "version" => "v3.1" })
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
        InlinedAttachments: [{
          'ContentType' => 'text/plain',
          'Filename' => file_name,
          'Base64Content' => Base64.encode64(content),
          'ContentId' => content_id
        }]
      )
    end

    it "should send email with HTML body and an attachment with API v3.0" do
      Mailjet.configure do |config|
        config.api_key = ENV['MJ_APIKEY_PUBLIC']
        config.secret_key = ENV['MJ_APIKEY_PRIVATE']
        config.api_version = "v3"
      end

      from_email = ENV['TEST_EMAIL']
      recipient  = ENV['TEST_EMAIL']

      message = Mail.new do
        from          from_email
        to            recipient
        subject       "This is a nice welcome email (API v3.0)"
        body          "Test"
        content_type  "text/html"
      end

      message.attachments['filename.txt'] = {
        mime_type: 'text/plain',
        content: "hello world"
      }

      sent = APIMailer.new.deliver!(message)

      expect(sent.attributes["Sent"].first["Email"]).to eq(ENV['TEST_EMAIL'])
    end

    it "should send email with Text body and an attachment with API v3.0" do
      Mailjet.configure do |config|
        config.api_key = ENV['MJ_APIKEY_PUBLIC']
        config.secret_key = ENV['MJ_APIKEY_PRIVATE']
        config.api_version = "v3"
      end

      from_email = ENV['TEST_EMAIL']
      recipient  = ENV['TEST_EMAIL']

      message = Mail.new do
        from          from_email
        to            recipient
        subject       "This is a nice welcome email (API v3.0)"
        body          "Test"
        content_type  "text/plain"
      end

      message.attachments['filename.txt'] = {
        mime_type: 'text/plain',
        content: "hello world"
      }

      sent = APIMailer.new.deliver!(message)

      expect(sent.attributes["Sent"].first["Email"]).to eq(ENV['TEST_EMAIL'])
    end

    it "should send email with HTML body and an attachment with API v3.1" do
      Mailjet.configure do |config|
        config.api_key = ENV['MJ_APIKEY_PUBLIC']
        config.secret_key = ENV['MJ_APIKEY_PRIVATE']
        config.api_version = "v3.1"
      end

      from_email = ENV['TEST_EMAIL']
      recipient  = ENV['TEST_EMAIL']

      message = Mail.new do
        from          from_email
        to            recipient
        subject       "This is a nice welcome email (API v3.1)"
        body          "Test"
        content_type  "text/html"
      end

      message.attachments['filename.txt'] = {
        mime_type: 'text/plain',
        content: "hello world"
      }

      sent = APIMailer.new.deliver!(message)

      expect(sent.attributes["Messages"].first["Status"]).to eq("success")
    end

    it "should send email with Text body and an attachment with API v3.1" do
      Mailjet.configure do |config|
        config.api_key = ENV['MJ_APIKEY_PUBLIC']
        config.secret_key = ENV['MJ_APIKEY_PRIVATE']
        config.api_version = "v3.1"
      end

      from_email = ENV['TEST_EMAIL']
      recipient  = ENV['TEST_EMAIL']

      message = Mail.new do
        from          from_email
        to            recipient
        subject       "This is a nice welcome email (API v3.1)"
        body          "Test"
        content_type  "text/plain"
      end

      message.attachments['filename.txt'] = {
        mime_type: 'text/plain',
        content: "hello world"
      }

      sent = APIMailer.new.deliver!(message)

      expect(sent.attributes["Messages"].first["Status"]).to eq("success")
    end

    it "should not send email without any Text or HTML body and an attachment with API v3.1 but raise a Mailjet::ApiError" do
      Mailjet.configure do |config|
        config.api_key = ENV['MJ_APIKEY_PUBLIC']
        config.secret_key = ENV['MJ_APIKEY_PRIVATE']
        config.api_version = "v3.1"
      end

      from_email = ENV['TEST_EMAIL']
      recipient  = ENV['TEST_EMAIL']

      message = Mail.new do
        from          from_email
        to            recipient
        subject       "This is a nice welcome email (API v3.1)"
      end

      message.attachments['filename.txt'] = {
        mime_type: 'text/plain',
        content: "hello world"
      }

      expect { APIMailer.new.deliver!(message) }.to raise_error(Mailjet::ApiError)
    end

    it 'should return data in attribute "Sent" using Send API v3.0' do

      Mailjet.configure do |config|
        config.api_key = ENV['MJ_APIKEY_PUBLIC']
        config.secret_key = ENV['MJ_APIKEY_PRIVATE']
        config.api_version = "v3"
      end

      recipient = { 'Email': ENV['TEST_EMAIL'] }

      message = Mailjet::Send.create(
        from_email: ENV['TEST_EMAIL'],
        from_name: 'Mailjet Ruby Wrapper CI',
        subject: 'Mailjet Ruby Wrapper CI Send API v3.0 spec',
        text_part: 'Mailjet Ruby Wrapper CI content',
        html_part: '<h3>Mailjet Ruby Wrapper CI content</h3>',
        recipients: [recipient]
      )

      expect(message.attributes['Sent'].first).to include(recipient)
    end

    it 'should return data in attribute "Sent" using API v3.1' do

      Mailjet.configure do |config|
        config.api_key = ENV['MJ_APIKEY_PUBLIC']
        config.secret_key = ENV['MJ_APIKEY_PRIVATE']
        config.api_version = "v3.1"
      end

      recipient = {
        'Email' => ENV['TEST_EMAIL'],
        'Name' => 'test'
      }

      message = Mailjet::Send.create(
        messages: [{
          'From' => {
            'Email' => ENV['TEST_EMAIL'],
            'Name' => 'Mailjet Ruby Wrapper CI'
          },
          'To' => [
            recipient
          ],
            'Subject' => 'Mailjet Ruby Wrapper CI Send API v3.1 spec',
            'TextPart' => 'Mailjet Ruby Wrapper CI content',
            'HTMLPart' => '<h3>Mailjet Ruby Wrapper CI content</h3>'
          }]
      )

      expect(message.attributes['Messages'].first['To'].first['Email']).to eq(ENV['TEST_EMAIL'])
    end
  end

  RSpec.describe Configuration do
    def reset_config
      # reset Mailjet::Configuration
      Mailjet.send(:remove_const, :Configuration) if Mailjet.const_defined?(:Configuration)
      load 'mailjet/configuration.rb'
    end

    before(:each) do
      reset_config
    end

    after(:each) do
      reset_config
    end

    it 'default configuration settings should be set' do
      Mailjet::Configuration::DEFAULT.each do |k,v|
        expect(Mailjet.config.send(k)).to eq(v)
      end
    end

    it 'default configuration settings should be override-able' do
      values = {
        api_version: 'something',
        end_point: 'something else',
        perform_api_call: 'and else',
      }

      Mailjet.configure do |config|
        config.api_version = values[:api_version]
        config.end_point = values[:end_point]
        config.perform_api_call = values[:perform_api_call]
      end

      Mailjet::Configuration::DEFAULT.each do |k,v|
        expect(Mailjet.config.send(k)).not_to eq(v)
        expect(Mailjet.config.send(k)).to eq(values[k])
      end
    end
  end
end
