require 'bundler'
begin
  require 'rspec/core/rake_task'
rescue LoadError
  puts "Please install rspec (bundle install)"
  exit
end

RSpec::Core::RakeTask.new :spec
Bundler::GemHelper.install_tasks

desc  "Run all specs with rcov"
RSpec::Core::RakeTask.new(:rcov) do |t|
  t.rcov = true
  t.rcov_opts = %w{--exclude osx\/objc,gems\/,spec\/,features\/}
end

task :default => [:spec]
