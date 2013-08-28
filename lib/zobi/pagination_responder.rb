# encoding: utf-8

module Responders
  module PaginationResponder

    def respond(*)
      if paginated?
        controller.headers['X-Total-Pages']   = resource.total_pages.to_s
        controller.headers['X-Current-Page']  = resource.current_page.to_s
        controller.headers['X-Limit-Value']   = resource.limit_value.to_s
      end
      super
    end

    private

    def paginated?
      resource.respond_to?(:total_pages) &&
        resource.respond_to?(:current_page) &&
        resource.respond_to?(:limit_value)
    end
  end
end
