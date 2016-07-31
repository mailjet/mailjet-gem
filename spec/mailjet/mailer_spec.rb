require 'mailjet'
require 'mailjet/mailer'

module Mailjet
  RSpec.describe APIMailer do
    it 'set proper fields also for multipart emails' do
      mocked_mail = double(
        :mail,
        :[] => nil,
        reply_to: nil,
        cc: nil,
        bcc: nil,
        subject: 'Test mocked mail',
        from: ['foo@bar.com'],
        to: ['bar@foo.com'],
        multipart?: true,
        text_part: double(:text_part, decoded: 'Hi!'),
        html_part: double(:html_part, decoded: '<strong>Hi!</strong>'),
        attachments: [],
        inlineattachment: []
      )

      expect(Mailjet::Send).to receive(:create).with(
        hash_including(
          html_part: '<strong>Hi!</strong>',
          html: '<strong>Hi!</strong>',
          text_part: 'Hi!',
          text: 'Hi!'
        )
      )

      APIMailer.new.deliver!(mocked_mail)
    end
  end
end
