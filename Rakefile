require "bundler/setup"
require "bundler/gem_tasks"
require "rake/testtask"
require "standard/rake"

task default: :test

Rake::TestTask.new do |t|
  t.pattern = "test/**/*_test.rb"
  t.warning = true
end
