# encoding: utf-8

if defined? Draper
  module Zobi
    class ResourceDecorator < Draper::Decorator
      delegate_all
    end
  end
end
