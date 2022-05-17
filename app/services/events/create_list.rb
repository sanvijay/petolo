# frozen_string_literal: true

require "active_support/hash_with_indifferent_access"

module Events
  class CreateList
    def initialize(event_list)
      @event_list = event_list
    end

    def create
      event_list.each do |event|
        ActiveSupport::HashWithIndifferentAccess.new(event)
        event = Event.new(event)

        unless event.save
          # Log error
          Rails.logger.warn event.errors.messages
        end
      end
    end

    private

    attr_reader :event_list
  end
end
