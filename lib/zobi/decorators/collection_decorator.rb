# encoding: utf-8

module Zobi
  class CollectionDecorator < Draper::CollectionDecorator
    include Draper::AutomaticDelegation
  end
end
