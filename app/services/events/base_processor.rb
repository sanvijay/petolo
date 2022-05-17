# frozen_string_literal: true

module Events
  class BaseProcessor
    def process; end

    private

    def parse_date(date_str, format)
      Date.strptime(date_str, format)
    end
  end
end
