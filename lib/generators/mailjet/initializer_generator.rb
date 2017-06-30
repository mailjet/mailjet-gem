module Mailjet
  class InitializerGenerator < Rails::Generators::Base
    desc 'This generator creates an initializer file mailjet.rb at config/initializers'

    source_root File.expand_path('../templates', __FILE__)

    def generate_initializer_file
      config_file_path = 'config/initializers/mailjet.rb'

      say('Hey! We’re about to configure your Mailjet credentials for your application.')
      say('You can find them on your account (https://app.mailjet.com/account/api_keys).')
      say('Please help yourself by providing some intel:')

      @api_key =      ask('API key: ')
      @secret_key =   ask('Secret key: ')
      @default_from = ask('Sender address:')

      say("Don't forget that your sender address '#{@default_from}' has to be validated first on https://app.mailjet.com/account/sender.")

      if @api_v3_1 = yes?('Do you want to use Mailjet API v3.1 for sending your emails? (y/n)')
        @api_v3_1_notice = %{
Mailjet API v3.1 is at the moment limited to Send API.
We’ve not set the version to it directly since there is no other endpoint in that version.
We recommend you create a dedicated instance of the wrapper set with it to send your emails.
If you're only using the gem to send emails, then you can safely set it to this version.
Otherwise, you can remove the dedicated line into #{config_file_path}.

}
        say(@api_v3_1_notice)
      end

      template 'mailjet.rb.erb', config_file_path
    end
  end
end
