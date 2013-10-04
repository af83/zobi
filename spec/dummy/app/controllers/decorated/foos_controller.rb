# encoding: utf-8
class Decorated::FoosController < ApplicationController
  extend Zobi
  behaviors :decorated, :inherited
end
