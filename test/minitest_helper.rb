require 'minitest/autorun'
require 'minitest/matchers'
require "mocha"
require 'mailjet'
require 'turn'

test_account = YAML::load(File.new(File.expand_path("../../config.yml", __FILE__)))['mailjet']

MiniTest::Spec.before do
  Mailjet.configure do |config|
    config.api_key = test_account['api_key']
    config.secret_key = test_account['secret_key']
    config.default_from = test_account['default_from']
  end
end

MiniTest::Spec.after do
  Object.send(:remove_const, 'Mailjet')
  Dir["#{File.dirname(__FILE__)}/../lib/**/*.rb"].each {|f| load f}
end

Turn.config.format = :outline
