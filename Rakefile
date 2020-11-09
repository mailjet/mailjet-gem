require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = [
    "spec/mailjet/mailer_spec.rb",
    "spec/configuration_spec.rb",
    "spec/mailjet_spec.rb",
    "spec/resources/contact_spec.rb",
    "spec/resources/messagehistory_spec.rb",
    "spec/resources/getcontactslists_spec.rb",
    "spec/resources/integration_spec.rb",
  ]
end

task default: [:spec]
