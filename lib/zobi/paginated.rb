# encoding: utf-8

module Zobi
  # This module helps you to paginate your collection using kaminari
  #
  module Paginated

    def self.included base
      base.send :responders, :pagination
    end

    protected

    def paginate_per
      params[:per]
    end

    private

    def paginated_collection c
      c.page(params[:page]).per(paginate_per)
    end
  end
end
