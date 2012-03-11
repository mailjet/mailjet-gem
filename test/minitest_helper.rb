require 'minitest/autorun'
require 'minitest/matchers'
require "mocha"
require 'mailjet'
require 'turn'

MiniTest::Spec.before do
  Mailjet.configure do |config|
    config.api_key = "eb9e14c48e0f753f1a45dd46856c5bbf" # test account benoit.benezech@gmail.com
    config.secret_key = "f406c28e8355b7811ecfaed88d72c79a"
  end
end

MiniTest::Spec.after do
  Object.send(:remove_const, 'Mailjet')
  Dir["#{File.dirname(__FILE__)}/../lib/**/*.rb"].each {|f| load f}
end


Turn.config.format = :outline