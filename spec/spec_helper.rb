# encoding: utf-8

ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../dummy/config/environment", __FILE__)
require 'rspec/rails'
require 'zobi'

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

require 'fixtures/fugu_controller'
