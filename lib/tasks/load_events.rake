# frozen_string_literal: true

namespace :load_events do
  desc "load events from external source"
  task :external, [:source] => [:environment] do |_t, args|
    Rails.logger = Logger.new($stdout)

    case args[:source]
    when "co_berlin"
      Events::CoBerlinProcessor.new.process
    when "visit_berlin"
      Events::VisitBerlinProcessor.new.process
    else
      puts "Please specify a valid source"
    end
  end
end
