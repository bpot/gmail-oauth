require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "gmail-oauth"
    gem.summary = %Q{Implements Gmail OAuth access methods for Net::IMAP and Net::SMTP}
    gem.description = %Q{Implements Gmail OAuth access methods for Net::IMAP and Net::SMTP}
    gem.email = "bobby.potter@gmail.com"
    gem.homepage = "http://github.com/bpot/gmail-oauth"
    gem.authors = ["Bob Potter"]
    gem.add_development_dependency "rspec", ">= 2.0.0.beta.16"
    gem.add_dependency "oauth"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |c|
  c.ruby_opts = "-rubygems"
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "gmail-oauth #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
