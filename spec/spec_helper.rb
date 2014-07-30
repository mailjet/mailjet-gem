require 'minitest/autorun'
require 'minitest/matchers'
require 'minitest/pride'
require 'minitest-spec-context'
require 'mocha/setup'
require 'mailjet'
require 'mailjet/resource'
require 'turn/autorun'

require File.expand_path './support/vcr_setup.rb', __dir__

def config_file
  File.expand_path("../../config.yml", __FILE__)
end

def config_file_exists?
  File.exists?(config_file)
end

def skip_if_no_config
  skip "No configuration file provided. Create config.yml to run it. See the README." unless config_file_exists?
end

if config_file_exists?
  test_account = YAML::load_file(config_file)['mailjet']

  MiniTest::Spec.before do
    Mailjet.configure do |config|
      config.api_key = test_account['api_key']
      config.secret_key = test_account['secret_key']
      config.end_point = test_account['end_point']
      config.default_from = test_account['default_from']
    end
  end
end

Turn.config.format = :outline
