require 'dotenv/load'
require 'memory_profiler'
require 'mailjet'
require 'benchmark'
require 'benchmark/ips'


Mailjet.configure do |config|
  config.api_key = ENV['MJ_APIKEY_PUBLIC']
  config.secret_key = ENV['MJ_APIKEY_PRIVATE']
end


def mailjet_send_example
  Mailjet::Send.create({
      messages: [{
      'From'=> {
          'Email'=> '$SENDER_EMAIL',
          'Name'=> 'Me'
      },
      'To'=> [
          {
              'Email'=> '$RECIPIENT_EMAIL',
              'Name'=> 'You'
          }
      ],
      'Subject'=> 'My first Mailjet Email!',
      'TextPart'=> 'Greetings from Mailjet!',
      'HTMLPart'=> '<h3>Dear passenger 1, welcome to <a href=\'https://www.mailjet.com/\'>Mailjet</a>!</h3><br />May the delivery force be with you!'
    }]
    },
    version: 'v3.1'
  )
end

report = MemoryProfiler.report do
  10.times do
    mailjet_send_example

    Mailjet::Listrecipient.all
    Mailjet::Listrecipient.first
  end
end
report.pretty_print

Benchmark.bm do |x|
  x.report('mailjet_send_example') { 20.times {mailjet_send_example} }
end

Benchmark.ips do |x|
  x.report('mailjet_send_example') { mailjet_send_example }
end
