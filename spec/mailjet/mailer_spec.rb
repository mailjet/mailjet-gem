
require 'mailjet'
require 'mailjet/mailer'

module Mailjet
  RSpec.describe APIMailer do
    it 'set proper fields also for multipart emails' do

			message = Mail.new()

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
          text_part: text,
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
				from 			"#{from_name} <#{from_email}>"
				to 				recipients
				cc 				ccR
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
				from 			"#{from_name} <#{from_email}>"
				to 				recipients
			end

			message.text_part = Mail::Part.new do 
				body text
			end

			message.html_part = Mail::Part.new do 
				body html
			end

      expect(Mailjet::Send).to receive(:create).with(
        hash_including(
					:text_part => text,
					:html_part => html
        )
      )

      APIMailer.new.deliver!(message)
    end

    it 'test with names in recipients list' do

			from_name = 'John'
			from_email = 'john@bar.com'
			recipients = ['test@test.com', 'paul <paul@test.com>']

			message = Mail.new do
				from 			"#{from_name} <#{from_email}>"
				to 				recipients
			end

			message.header['X-MJ-ping'] = 'pong'
			message.header['ping'] = 'pong'
			message.header['template'] = 'pong'

      expect(Mailjet::Send).to receive(:create).with(
        hash_including(
					:headers => { "X-MJ-ping" => "pong" }
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
				from 			"#{from_name} <#{from_email}>"
				to 				recipients
				reply_to 	rt
			end

      expect(Mailjet::Send).to receive(:create).with(
        hash_including(
					:reply_to => rt
        )
      )

      APIMailer.new.deliver!(message)
    end

    it 'test with one recipient' do

			from_name = 'Albert'
			from_email = 'albert@bar.com'
			recipients = 'test@test.com'

			message = Mail.new do
				from 			"#{from_name} <#{from_email}>"
				to 				recipients
			end

      expect(Mailjet::Send).to receive(:create).with(
        hash_including(
					:to => recipients
        )
      )

      APIMailer.new.deliver!(message)
    end
	end
end
