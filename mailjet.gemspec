#encoding: utf-8

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mailjet/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mailjet"
  s.version     = Mailjet::VERSION
  s.authors     = ["Aurélien AMILIN", "Benoit Bénézech"]
  s.email       = ["benoit.benezech@gmail.com"]
  s.homepage    = "http://www.mailjet.com"
  s.summary     = "Cloud Emailing for easy delivery."
  s.description = "Cloud Emailing for easy delivery."

  s.files = Dir["{lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "activesupport", ">= 3.0.9"
  s.add_development_dependency "actionmailer", ">= 3.0.9"
  s.add_development_dependency "minitest"
  s.add_development_dependency "minitest-matchers"
  s.add_development_dependency "turn"
  s.add_development_dependency "rake"
  s.add_development_dependency "json"
  s.add_development_dependency "rack"
  s.add_development_dependency "mocha"
end
