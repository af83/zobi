# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'zobi/version'

Gem::Specification.new do |s|
  s.name         = "zobi"
  s.version      = Zobi::VERSION
  s.authors      = ["klacointe"]
  s.email        = "kevinlacointe@gmail.com"
  s.homepage     = "https://github.com/af83/zobi"
  s.summary      = "Keep your rails controllers DRY."
  s.description  = "Keep your rails controllers DRY while using devise, inherited_resources, has_scope, kaminari, pundit and draper"
  s.license      = 'MIT'
  s.files        = `git ls-files README.md lib app LICENSE`.split("\n")
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'
  s.add_dependency "rails", "~>4.0"
  s.add_development_dependency "rspec-rails", "~>2.14"
  s.add_development_dependency "sqlite3", "~>1.3"
  s.add_development_dependency "rake", "~>10.1"
  s.add_development_dependency "responders", "~>1.0"
  s.add_development_dependency "inherited_resources", "~>1.4"
  s.add_development_dependency "has_scope", "~>0.6.0.rc"
  s.add_development_dependency "kaminari", "~>0.14"
  s.add_development_dependency "pundit", "~>0.2"
  s.add_development_dependency "draper", "~>1.3"
  s.add_development_dependency "devise", "~>3.2"
  s.add_development_dependency "jquery-rails", "~>3.0"
  s.add_development_dependency "faker", "~>1.2"
  s.add_development_dependency "pry-rails", "~>0.3"
  s.add_development_dependency "database_cleaner", "~>1.1"
end
