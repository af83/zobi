# encoding: utf-8

class FooDecorator < Draper::Decorator
  include Draper::AutomaticDelegation

  def name_and_category
    name + category
  end
end
