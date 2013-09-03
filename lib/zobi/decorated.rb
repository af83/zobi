# encoding: utf-8

module Zobi
  # This module decorate your collection and resource
  #
  module Decorated

    protected

    def collection_decorator_class
      if self.class.to_s.index('::')
        "#{self.class.to_s.split('::').first}::CollectionDecorator".constantize
      else
        ::CollectionDecorator
      end
    end

    def decorator_class
      "#{self.class.to_s.sub('Controller', '').singularize}Decorator".constantize
    end

    private

    def decorated_collection c
      collection_decorator_class.decorate(c, with: decorator_class)
    end

    def resource
      @resource ||= decorator_class.decorate super
    end

  end
end
