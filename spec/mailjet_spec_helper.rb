require "bundler/setup"
require "mailjet"
require "active_support/core_ext"
require "dotenv"
require "vcr"
Bundler.setup

Dotenv.load

Mailjet.configure do |config|
  config.api_key = ENV["MJ_APIKEY_PUBLIC"]
  config.secret_key = ENV["MJ_APIKEY_PRIVATE"]
  config.api_version = "v3"
  config.default_from = "pilot@example.com"
end

VCR.configure do |c|
  c.cassette_library_dir = "spec/cassettes"
  c.hook_into :webmock

  c.default_cassette_options = {
    :match_requests_on => [:uri, :method, :body],
  }

  c.filter_sensitive_data("<BASIC>") do |interaction|
    interaction.request.headers["Authorization"].first
  end

  c.configure_rspec_metadata!
end
