# encoding: utf-8

module Zobi
  # This module add some helpers to controllers.
  #
  #   * inherit_resources
  #   * params filtering
  #
  module Inherited
    def self.included(klass)
      klass.inherit_resources
      klass.send('include', Inherited::Hidden)
    end

    private

    def inherited_collection c
      end_of_association_chain
    end

    module Hidden
      protected

      # This method can be overwritted in controllers
      def permitted_params
        @permitted_params ||= parameters_class.new(self, params).params
      end

      private

      def parameters_class
        klass = "Parameters::#{self.class.to_s.sub('Controller', '').singularize}"
        klass.constantize
      rescue NameError
        raise <<EOT
You need to define the class #{klass} or overwrite the permitted_params method in your controller.
EOT
      end
    end

  end
end
