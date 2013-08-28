# encoding: utf-8

module Zobi
  module Included

    protected

    def includes
      nil
    end

    private

    def included_collection c
      c = c.includes(*includes) if includes.present?
      c
    end

  end
end
