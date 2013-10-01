class Decorated::FoosController < ApplicationController
  extend Zobi
  behaviors :decorated, :inherited
end
