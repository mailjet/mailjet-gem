require 'minitest/autorun'
require 'minitest/matchers'
require "mocha"
require 'mailjet'
require 'turn'

MiniTest::Spec.before do
  Mailjet.configure do |config|
    config.api_key = ""
    config.secret_key = ""
  end
end

MiniTest::Spec.after do
  Object.send(:remove_const, 'Mailjet')
  Dir["#{File.dirname(__FILE__)}/../lib/**/*.rb"].each {|f| load f}
end


Turn.config.format = :outline