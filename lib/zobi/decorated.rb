# encoding: utf-8

module Zobi
  # This module decorate your collection and resource
  # NB: dependencie on Inherited module
  #
  module Decorated

    protected

    def collection_decorator_class
      Zobi::Discover.new(self.class, :decorated, :collection).resolve
    end

    def decorator_class
      Zobi::Discover.new(self.class, :decorated, :resource).resolve
    end

    private

    def decorated_collection c
      collection_decorator_class.decorate(
        (c.is_a?(Class) ? c.all : c),
        with: decorator_class
      )
    end

    def resource
      @resource ||= decorator_class.decorate super
    end
  end
end
