require 'minitest/autorun'
require 'minitest/matchers'
require 'minitest/pride'
require 'minitest-spec-context'
require 'mocha/setup'
require 'mailjet'
require 'mailjet/resource'
require 'turn/autorun'

require File.expand_path './support/vcr_setup.rb', __dir__

test_account = YAML::load(File.new(File.expand_path("../../config.yml", __FILE__)))['mailjet']

MiniTest::Spec.before do
  Mailjet.configure do |config|
    config.api_key = test_account['api_key']
    config.secret_key = test_account['secret_key']
    config.end_point = test_account['end_point']
    config.default_from = test_account['default_from']
  end
end

Turn.config.format = :outline
