class Scoped::FoosController < ApplicationController
  extend Zobi
  behaviors :scoped

  has_scope :by_name
  has_scope :by_category
  has_scope :by_order, using: [:order, :direction]

  def index
  end
end
