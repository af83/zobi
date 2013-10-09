# encoding: utf-8

module Zobi
  # This module decorate your collection and resource
  # NB: dependencie on Inherited module
  #
  module Decorated

    protected

    def collection_decorator_class
      Decorated.discover_collection_decorator self.class
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

    class << self

      def discover_collection_decorator klass
        collection_decorators_discovery(klass).each do |decorator|
          begin
            return decorator.constantize
          rescue NameError
            next
          end
        end
        Zobi::CollectionDecorator
      end

      def collection_decorators_discovery klass
        decorators = []
        ns = Zobi.namespaces_from_class klass
        decorators << Zobi.classes_for_namespaces(
          ns, klass.to_s.demodulize.gsub('Controller', 'Decorator')
        )
        decorators << Zobi.classes_for_namespaces(ns, 'CollectionDecorator')
        decorators.flatten
      end

    end

  end
end
