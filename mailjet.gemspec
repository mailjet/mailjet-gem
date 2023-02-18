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

  s.post_install_message = %q{
  The Ruby wrapper for Mailjet has just been installed successfully, congrats!
  Maybe you want to configure your credentials to use your account.
  All informations available on https://github.com/mailjet/mailjet-gem.
  But if you are using Rails, you'll be glad to generate it easily using:

    $ rails generate mailjet:initializer

  We hope you will enjoy Mailjet!

}

  s.files = Dir["{lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "activesupport", ">= 5.0.0"
  s.add_dependency "rack", ">= 1.4.0"
  s.add_dependency "rest-client", ">= 2.1.0"
  s.add_development_dependency "actionmailer", ">= 5.0.0"
  s.add_development_dependency "rake"
  s.add_development_dependency "json"
  s.add_development_dependency "webmock"
  s.add_development_dependency "vcr"
  s.add_development_dependency "rspec"
  s.add_development_dependency "dotenv"

  s.required_ruby_version = ">= 2.2.0"
end
