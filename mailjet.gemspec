#encoding: utf-8

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mailjet/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mailjet"
  s.version     = Mailjet::VERSION
  s.authors     = ["Tyler Nappy", "Jean-Baptiste Escoyez", "Aurélien AMILIN", "Benoit Bénézech"]
  s.email       = ["tyler@mailjet.com", "devrel-team@mailjet.com", "jbescoyez@gmail.com"]
  s.homepage    = "http://www.mailjet.com"
  s.summary     = "Mailjet a powerful all-in-one email service provider clients can use to get maximum insight and deliverability results from both their marketing and transactional emails. Our analytics tools and intelligent APIs give senders the best understanding of how to maximize benefits for each individual contact, with each email sent."
  s.description = "Ruby wrapper for Mailjet's v3 API"


  s.files = Dir["{lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "activesupport", ">= 3.1.0"
  s.add_dependency "rack", ">= 1.4.0"
  s.add_dependency "rest-client"
  s.add_development_dependency "actionmailer", ">= 3.0.9"
  s.add_development_dependency "minitest"
  s.add_development_dependency "minitest-matchers"
  s.add_development_dependency "minitest-spec-context"
  s.add_development_dependency "turn"
  s.add_development_dependency "rake"
  s.add_development_dependency "json"
  s.add_development_dependency "mocha"
  s.add_development_dependency "webmock"
  s.add_development_dependency "vcr"
  s.add_development_dependency 'guard'
  s.add_development_dependency 'guard-minitest'
  # s.add_development_dependency 'debugger' #removed for compatability reasons
  s.add_development_dependency "rspec" #added this
  s.add_development_dependency "rspec-expectations" #added this
  s.add_development_dependency "dotenv" #added this

end
