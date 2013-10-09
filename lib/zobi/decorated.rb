# encoding: utf-8

module Zobi
  # This module decorate your collection and resource
  # NB: dependencie on Inherited module
  #
  module Decorated

    protected

    def collection_decorator_class
      discover_collection_decorator || Zobi::CollectionDecorator
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

    # FIXME Ugly…
    def discover_collection_decorator
      decorators = ['CollectionDecorator']
      original = self.class.to_s.gsub('Controller', 'Decorator')
      base_name = original.demodulize
      ns = self.class.to_s.split('::')
      ns.pop
      ns.size.times do |i|
        decorators << (ns[0..i] << 'CollectionDecorator').join('::')
      end
      decorators << base_name
      ns.size.times do |i|
        decorators << (ns[0..i] << base_name).join('::')
      end
      decorators << original
      decorators.uniq.reverse.each do |decorator|
        begin
          return decorator.constantize
        rescue NameError
          next
        end
      end
      nil
    end

  end
end
