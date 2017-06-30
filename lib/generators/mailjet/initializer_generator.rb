module Mailjet
  class InitializerGenerator < Rails::Generators::Base
    desc 'This generator creates an initializer file mailjet.rb at config/initializers'

    source_root File.expand_path('../templates', __FILE__)

    def generate_initializer_file
      say('Hey! We’re about to configure your Mailjet credentials for your application.')
      say('You can find them on your account (https://app.mailjet.com/transactional).')
      say('Please help yourself by providing some intel:')

      @api_key =      ask('API key: ')
      @secret_key =   ask('Secret key: ')
      @default_from = ask('Sender address:')
      @api_v3_1 =     yes?('Do you want to use Mailjet API v3.1? (y/n)')

      template 'mailjet.rb.erb', 'config/initializers/mailjet.rb'
    end
  end
end
