# encoding: utf-8

if defined? Draper
  module Zobi
    class CollectionDecorator < Draper::CollectionDecorator
      include Draper::AutomaticDelegation
    end
  end
end
