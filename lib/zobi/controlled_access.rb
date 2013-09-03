# encoding: utf-8

module Zobi
  # This module help to manage control access on your collection using pundit.
  #
  module ControlledAccess

    def self.included base
      base.send :include, Pundit
      base.before_filter :authorize_resource
    end

    def policy_scope scope
      Pundit.policy_scope!(controlled_access_user, scope)
    end

    def policy record
      Pundit.policy!(controlled_access_user, record)
    end

    protected

    # Authorize resource, see Policies.
    def authorize_resource
      case action_name
      when build_resources_authorized
        authorize build_resource
      when resources_authorized
        authorize resource
      end
    end

    def controlled_access_user
      if self.class.to_s.split('::').first == 'Admin'
        current_administrator
      else
        current_user
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
  end
end
