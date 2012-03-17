#!/usr/bin/env rake
require 'rake/testtask'

$:.push File.expand_path("../lib", __FILE__)

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end


task :default => :test
