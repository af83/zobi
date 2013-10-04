# encoding: utf-8
class Foo < ActiveRecord::Base
  scope :by_name,     ->(name)        { where(name: name) }
  scope :by_category, ->(category)    { where(category: category) }
  scope :by_order,    ->(field, dir)  { order("#{field} #{dir}") }
end
