# frozen_string_literal: true
module Scheduled
  class LoadCoBerlinJob
    @queue = Resque::Queue::LOW

    class << self
      def perform
        Events::CoBerlinProcessor.new.process
      end
    end
  end
end
