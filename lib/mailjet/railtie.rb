require 'rails'
require 'mailjet/mailer'

module Mailjet
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'mailjet/tasks.rb'
    end
  end
end