require 'rails'
require 'mailjet/mailer'

module Mailjet
  class Railtie < Rails::Railtie
    initializer :after_initialize do
      ActiveSupport.on_load(:action_mailer) do
        ActionMailer::Base.send(:extend, Mailjet::Mailer)
      end
    end

    rake_tasks do
      load 'mailjet/tasks.rb'
    end
  end
end