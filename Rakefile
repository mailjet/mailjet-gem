require "rspec/core/rake_task"
require 'bundler/gem_tasks'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = "spec/**/*_spec.rb"
end

task default: [:spec]
