# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{gmail-oauth}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Bob Potter"]
  s.date = %q{2010-07-08}
  s.description = %q{Implements Gmail OAuth access methods for Net::IMAP and Net::SMTP}
  s.email = %q{bobby.potter@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.markdown"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.markdown",
     "Rakefile",
     "VERSION",
     "examples/three_legged_imap.rb",
     "examples/three_legged_smtp.rb",
     "lib/gmail-oauth.rb",
     "lib/gmail-oauth/client.rb",
     "lib/gmail-oauth/request.rb",
     "spec/gmail-oauth_request_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/bpot/gmail-oauth}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Implements Gmail OAuth access methods for Net::IMAP and Net::SMTP}
  s.test_files = [
    "spec/gmail-oauth_request_spec.rb",
     "spec/spec_helper.rb",
     "examples/three_legged_smtp.rb",
     "examples/three_legged_imap.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 2.0.0.beta.16"])
      s.add_runtime_dependency(%q<oauth>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 2.0.0.beta.16"])
      s.add_dependency(%q<oauth>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 2.0.0.beta.16"])
    s.add_dependency(%q<oauth>, [">= 0"])
  end
end

