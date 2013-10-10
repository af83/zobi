# encoding: utf-8

module Zobi
  Discover = Struct.new(:klass, :behavior, :type) do
    CONFIG = {
      decorated: {
        suffix: 'Decorator',
        resource: 'ResourceDecorator',
        collection: 'CollectionDecorator'
      }
    }.freeze

    def resolve
      discovery.each do |klass|
        begin
          return klass.constantize
        rescue NameError
          next
        end
      end
      "Zobi::#{fallback}".constantize
    end

    private

    def namespaces
      last = ""
      ns = klass.to_s.split('::')
      ns.pop
      ns.map{|i| last += "::#{i}"}.reverse.push '::'
    end

    def resource_class
      collection_class.singularize
    end

    def collection_class
      klass.to_s.demodulize.gsub('Controller', '')
    end

    def base_class
      type == :resource ? resource_class : collection_class
    end

    def discovery
      discovery = []
      discovery << self.class.classes_for_namespaces(
        namespaces, "#{base_class}#{suffix}"
      )
      discovery << self.class.classes_for_namespaces(namespaces, fallback)
      discovery.flatten
    end

    def fallback
      CONFIG[behavior][type]
    end

    def suffix
      CONFIG[behavior][:suffix]
    end

    class << self
      def classes_for_namespaces namespaces, base_name
        namespaces.map{|ns|
          "#{ns == '::' ? ns : "#{ns}::"}#{base_name}"
        }
      end
    end
  end
end
