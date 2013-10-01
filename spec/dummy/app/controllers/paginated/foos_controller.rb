class Paginated::FoosController < ApplicationController
  extend Zobi
  behaviors :paginated

  def paginate_per
    10
  end
end
