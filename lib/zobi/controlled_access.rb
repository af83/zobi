# encoding: utf-8

module Zobi
  # This module help to manage control access on your collection using pundit.
  #
  module ControlledAccess

    def self.included base
      base.send :include, Pundit
      base.class_eval do
        before_filter :authorize_resource

        def policy_scope scope
          Pundit.policy_scope!(controlled_access_user, scope)
        end

        def policy record
          Pundit.policy!(controlled_access_user, record)
        end
      end
    end

    protected

    # Authorize resource, see Policies.
    def authorize_resource
      case action_name
      when build_resources_authorized
        authorize controlled_access_build_resource
      when resources_authorized
        authorize controlled_access_resource
      end
    end

    def controlled_access_user
      if self.class.to_s.split('::').first == 'Admin'
        begin
          current_administrator
        rescue NameError
          raise "You need to define the current_administrator method.".inspect
        end
      else
        begin
          current_user
        rescue NameError
          raise "You need to define the current_user method.".inspect
        end
      end
    end

    private

    def controlled_access_collection c
      policy_scope c
    end

    def build_resources_authorized
      /new|create/
    end

    def resources_authorized
      /edit|update|show|destroy/
    end

    def controlled_access_build_resource
      return build_resource if respond_to?(:build_resource)
      zobi_resource_class.new params[zobi_resource_class.to_s.to_sym]
    end

    def controlled_access_resource
      return resource if respond_to?(:resource)
      zobi_resource_class.find(params[:id])
    end
  end
end
