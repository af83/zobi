# encoding: utf-8
module Zobi
  # This class responsability is to filter parameters before sending it to the
  # model.
  #
  # This class is meant to be inherited.
  #
  # Most of the time, two methods will be overriden: `fields` and
  # `translated_fields`.
  #
  # If you need complex logic based on context of execution (user rights and so
  # on...), you have access to the controller through the `context` attr.
  # Meaning, `context.current_user` is possible. And then, you can implement
  # all the `if` possible in the world.
  #
  class ParametersSanitizer
    attr_reader :context, :canonical_params
    private :context, :canonical_params

    # @param [ApplicationController] context
    # @param [ActionController::Parameters] canonical_params
    #
    # @return [Sanitizer]
    #
    def initialize(context, canonical_params)
      @context, @canonical_params = context, canonical_params
    end

    # The only public method. Return sanitized parameters.
    #
    # @return [ActionController::Parameters]
    #
    def params
      canonical_params.permit resource_type => permitted_fields
    end

    protected

    # @return [Array] array of fields
    #
    def fields
      []
    end

    # @return [Array] array of translated fields
    #
    def translated_fields
      []
    end

    # @return [Array] array of locales
    #
    def locales
      I18n.available_locales
    end

    # Computes all the fields
    #
    # @return [Array] Complete list of fields
    #
    def permitted_fields
      fields + locales.map {|l| translated_fields.map {|f| "#{f}_#{l}" }}
    end

    # @return [Symbol] The resource name to be required
    #
    def resource_type
      self.class.to_s.demodulize.gsub('Parameters', '').underscore.to_sym
    end
  end
end
