require 'base64'
require 'mailjet'
require 'mailjet/mailer'

module Mailjet
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

      message.header['X-MJ-ping'] = 'pong'
      message.header['ping'] = 'pong'
      message.header['template'] = 'pong'

      expect(Mailjet::Send).to receive(:create).with(
        hash_including(
          headers: { 'X-MJ-ping' => 'pong' }
        )
      )

      APIMailer.new.deliver!(message)
    end

    it 'test the reply_to prop' do
      from_name = 'Albert'
      from_email = 'albert@bar.com'
      recipients = ['test@test.com', 'paul <paul@test.com>']
      rt = 'john@test.com'

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

    # it 'test the attachments' do
    #   from_name = 'Albert'
    #   from_email = 'albert@bar.com'
    #   recipients = 'test@test.com'
    #
    #   file = Base64.encode64(File.open(File.expand_path('../testAttachments.txt', __FILE__), 'rb').read)
    #
    #   message = Mail.new do
    #     from       "#{from_name} <#{from_email}>"
    #     to         recipients
    #     add_file   file
    #   end
    #
    #   expect(Mailjet::Send).to receive(:create).with(
    #     hash_including(
    #       attachments: [{
    #         'Content-Type' => 'text/plain',
    #         'Filename' => 'testAttachments.txt',
    #         'content' => file
    #       }]
    #     )
    #   )
    #
    #   APIMailer.new.deliver!(message)
    # end
  end
end
