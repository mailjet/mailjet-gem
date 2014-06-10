#!/usr/bin/env rake
require 'rake/testtask'
require 'bundler'
Bundler::GemHelper.install_tasks

$:.push File.expand_path("../lib", __FILE__)

Rake::TestTask.new(:spec) do |t|
  t.libs << 'lib'
  t.libs << 'spec'
  # t.pattern = 'spec/**/*_spec.rb'
  t.verbose = true
  t.test_files = Dir['spec/**/*_spec.rb']
end


task :default => :spec
