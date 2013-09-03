# encoding: utf-8

require 'zobi/inherited'
require 'zobi/decorated'
require 'zobi/controlled_access'
require 'zobi/included'
require 'zobi/paginated'
require 'zobi/scoped'
require 'zobi/pagination_responder'

module Zobi
  BEHAVIORS = [:inherited, :scoped, :included, :paginated, :controlled_access, :decorated].freeze

  def behaviors *behaviors
    behaviors.each do |behavior|
      self.send(:include, behavior_module(behavior))
    end
    self.send(:include, ::Zobi::InstanceMethods)
  end

  def behavior_module name
    "Zobi::#{name.to_s.camelize}".constantize
  end

  module InstanceMethods

    def zobi_resource_class
      return resource_class if respond_to?(:resource_class)
      self.class.name.demodulize.gsub('Controller', '').singularize
    end

    def collection
      return @collection if @collection
      c = zobi_resource_class
      BEHAVIORS.each do |behavior|
        next unless self.class.ancestors.include?(self.class.behavior_module(behavior))
        c = self.send :"#{behavior}_collection", c
      end
      @collection = c
    end

  end

end
