module Parameters
  module Inherited
    class Foo < Zobi::ParametersSanitizer
      def fields
        [:name, :category, :published]
      end
    end
  end
end
