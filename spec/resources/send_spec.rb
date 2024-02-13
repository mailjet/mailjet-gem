require "mailjet_spec_helper"

RSpec.describe Mailjet::Send do
  it 'returns data in attribute "Sent"' do
    VCR.use_cassette("resource/send") do
      recipient = { "Email": "passenger@example.com" }

      message = described_class.create(
        from_email: "pilot@example.com",
        from_name: 'Mailjet Ruby Wrapper CI',
        subject: 'Mailjet Ruby Wrapper CI Send API v3.0 spec',
        text_part: 'Mailjet Ruby Wrapper CI content',
        html_part: 'HTML Mailjet Ruby Wrapper CI content',
        recipients: [recipient]
      )

      expect(message.attributes['Sent'].first).to include(recipient)
    end
  end

  it 'returns data in attribute "Sent" for API v3.1' do
    VCR.use_cassette("resource/send_v31") do
      recipient = {
        'Email' => "passenger@example.com",
        'Name' => 'test'
      }

      message = described_class.create({
        messages: [{
          'From' => {
            'Email' => "pilot@example.com",
            'Name' => 'Mailjet Ruby Wrapper CI'
          },
          'To' => [
            recipient
          ],
            'Subject' => 'Mailjet Ruby Wrapper CI Send API v3.1 spec',
            'TextPart' => 'Mailjet Ruby Wrapper CI content',
            'HTMLPart' => 'HTML Mailjet Ruby Wrapper CI content'
          }]
        },
        version: 'v3.1'
      )

      expect(message.attributes['Messages'].first['To'].first['Email']).to eq "passenger@example.com"
    end
  end

  it 'returns HTTP 401 while using invalid credentials for API v3.1' do
    VCR.use_cassette("resource/send_v31_invalid_credentials") do
      recipient = {
        'Email' => "passenger@example.com",
        'Name' => 'test'
      }

      message = {
        messages: [{
          'From' => {
            'Email' => "pilot@example.com",
            'Name' => 'Mailjet Ruby Wrapper CI'
          },
          'To' => [
            recipient
          ],
            'Subject' => 'Mailjet Ruby Wrapper CI Send API v3.1 spec',
            'TextPart' => 'Mailjet Ruby Wrapper CI content',
            'HTMLPart' => 'HTML Mailjet Ruby Wrapper CI content'
          }]
        }

      expect{ described_class.create(message, version: 'v3.1') }.to raise_error(Mailjet::Unauthorized, /401 Unauthorized/)
    end
  end
end
