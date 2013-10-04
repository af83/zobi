# encoding: utf-8
class Paginated::FoosController < ApplicationController
  extend Zobi
  behaviors :paginated
  respond_to :html

  def index
    respond_with collection
  end

  def paginate_per
    10
  end
end
