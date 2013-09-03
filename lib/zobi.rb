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

  def self.included base
    base.extend ClassMethods
  end

  def collection
    return @collection if @collection
    c = resource_class
    BEHAVIORS.each do |behavior|
      c = self.send :"#{behavior}_collection", c
    end
    @collection = c
  end

  module ClassMethods

    def behaviors *behaviors
      self.send(:include, ::Zobi::Hidden)
      behaviors.each do |behavior|
        self.send(:include, "Zobi::#{behavior.to_s.camelize}".constantize)
      end
    end

  end

  module Hidden

    BEHAVIORS.each do |behavior|
      define_method :"#{behavior}_collection" do |c|
        c
      end
    end

  end

end
