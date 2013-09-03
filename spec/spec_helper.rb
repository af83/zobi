# encoding: utf-8

require 'action_controller'
require 'zobi'

class FakeController < ActionController::Base
  include Zobi
  behaviors *[]
end
