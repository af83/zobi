# encoding: utf-8

ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../dummy/config/environment", __FILE__)
require 'rspec/rails'

require 'action_controller'
require 'inherited_resources'
require 'zobi'
