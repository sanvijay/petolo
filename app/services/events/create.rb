# frozen_string_literal: true

require "active_support/hash_with_indifferent_access"

module Events
  class Create
    def initialize(params)
      @params = ActiveSupport::HashWithIndifferentAccess.new(params)
    end

    def create
      Event.create!(@params)
    end
  end
end
