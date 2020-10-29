require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = [
    "spec/mailjet/mailer_spec.rb",
    "spec/configuration_spec.rb",
    "spec/mailjet_spec.rb",
  ]
end

task default: [:spec]
