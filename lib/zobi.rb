# encoding: utf-8

Dir["#{File.dirname(__FILE__)}/zobi/**/*.rb"].each { |f| require f }

module Zobi
  BEHAVIORS = [:inherited, :scoped, :included, :paginated, :controlled_access, :decorated].freeze

  def self.extended base
    base.helper_method :collection, :resource
  end

  def behaviors *behaviors
    (BEHAVIORS & behaviors).each do |behavior|
      send(:include, behavior_module(behavior))
    end
    send(:include, ::Zobi::InstanceMethods)
  end

  def behavior_module name
    "Zobi::#{name.to_s.camelize}".constantize
  end

  def behavior_included? name
    ancestors.include?(behavior_module(name))
  end

  module InstanceMethods

    def zobi_resource_class
      return resource_class if self.class.behavior_included?(:inherited)
      self.class.name.demodulize.gsub('Controller', '').singularize.constantize
    end

    def collection
      return @collection if @collection
      c = zobi_resource_class
      BEHAVIORS.each do |behavior|
        next unless self.class.behavior_included?(behavior)
        c = send :"#{behavior}_collection", c
      end
      @collection = (c.is_a?(Class) ? c.all : c)
    end

  end

end
