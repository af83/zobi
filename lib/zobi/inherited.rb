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

      def permitted_params
        @permitted_params ||= parameters_class.new(self, params).params
      end

      private

      def parameters_class
        "Parameters::#{self.class.to_s.sub('Controller', '').singularize}".constantize
      end
    end

  end
end
