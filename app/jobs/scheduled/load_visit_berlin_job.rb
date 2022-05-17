# frozen_string_literal: true
module Scheduled
  class LoadVisitBerlinJob
    @queue = Resque::Queue::LOW

    class << self
      def perform
        Events::VisitBerlinProcessor.new.process
      end
    end
  end
end
