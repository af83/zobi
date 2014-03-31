# encoding: utf-8

module Zobi
  # This module helps you to filter your collection using has_scope
  #
  module Scoped
    def self.included(klass)
      klass.helper_method :filters_list
      klass.before_filter :default_order
    end

    protected

    def filters_list
      Hash(scopes_configuration).keys
    end

    private

    def scoped_collection c
      apply_scopes c
    end

    def default_order
      return unless params[:by_order]
      {order: 'created_at', direction: 'desc'}.each do |k, v|
        next if params[:by_order][k].present?
        params[:by_order][k] = v
      end
    end
  end
end
