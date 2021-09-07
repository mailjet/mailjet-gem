require "mailjet_spec_helper"

RSpec.describe Mailjet::Send do
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

  context 'when not supported version provided' do
    it 'raises an error' do
      recipient = {
        'Email' => "passenger@example.com",
        'Name' => 'test'
      }

      expect{ described_class.create({
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
        version: 'v3'
      ) }.to raise_error(
        "API version is not supported by this endpoint. Supported versions: #{described_class.supported_versions.join(',')}"
      )
    end
  end
end
