require "rspec/core/rake_task"
require 'bundler/gem_tasks'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = [
    "spec/mailjet/rack/endpoint_spec.rb",
    "spec/mailjet/api_error_spec.rb",
    "spec/mailjet/apikey_spec.rb",
    "spec/mailjet/mailer_spec.rb",
    "spec/mailjet/resource_spec.rb",
    "spec/configuration_spec.rb",
    "spec/mailjet_spec.rb",
    "spec/resources/contact_spec.rb",
    "spec/resources/contactmetadata_spec.rb",
    "spec/resources/messagehistory_spec.rb",
    "spec/resources/getcontactslists_spec.rb",
    "spec/resources/template_detailcontent_spec.rb",
    "spec/resources/integration_spec.rb",
    "spec/resources/newsletter_spec.rb",
    "spec/resources/statcounters_spec.rb",
    "spec/resources/send_spec.rb",
    "spec/resources/resource_spec.rb",
  ]
end

task default: [:spec]
