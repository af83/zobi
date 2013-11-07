# encoding: utf-8
module Inherited
  class FooParameters < Zobi::ParametersSanitizer
    def fields
      [:name, :category, :published]
    end
  end
end
