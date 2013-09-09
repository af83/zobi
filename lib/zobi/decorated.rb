# encoding: utf-8

module Zobi
  # This module decorate your collection and resource
  # NB: dependencie on Inherited module
  #
  module Decorated

    protected

    def collection_decorator_class
      "#{self.class.to_s.split('::').first}::CollectionDecorator"
        .constantize
    rescue NameError
      Zobi::CollectionDecorator
    end

    def decorator_class
      klass = "#{self.class.to_s.sub('Controller', '').singularize}Decorator"
      klass.constantize
    rescue NameError
      raise <<EOT
You need to define the class #{klass} to use decorated behavior of Zobi.
EOT
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
