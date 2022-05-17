# frozen_string_literal: true

module Events
  class VisitBerlinProcessor < BaseProcessor
    def initialize
      super

      @source = "visit_berlin"
      @domain = "https://www.visitberlin.de"
      @url = "#{domain}/en/event-calendar-berlin"

      @events = []
    end

    def process
      content.children.each do |child|
        next unless child.is_a?(Nokogiri::XML::Element) && child["class"] == "l-list__item"

        event = process_event(child)

        events.push(event)
      end

      Events::CreateList.new(events).create
    end

    private

    attr_reader :events, :source, :domain, :url

    def process_event(child)
      event_dates = parse_dates(child)

      {
        source: "visit_berlin",
        event_link: domain + child.children.css("a")[0]["href"],
        title: child.css(".heading-highlight__inner span").text.strip,
        description: child.css(".teaser-search__text div").text.strip,
        start_date: event_dates[:start_date],
        end_date: event_dates[:end_date]
      }
    end

    def content
      return @content if @content

      fh = URI.parse(url).open
      html = fh.read
      parsed_data = Nokogiri::HTML.parse(html)

      @content = parsed_data.css(".l-list")
    end

    def parse_dates(child)
      event_date_string = child.css(".teaser-search__date").text.strip.gsub(/\s+/, " ")
      date_format = "%d/%m/%Y"

      if event_date_string.include? "additional date"
        event_date = event_date_string.sub(/(.*?) \+.*$/, '\1')

        { start_date: parse_date(event_date, date_format) }
      elsif !event_date_string.include? "Permanent exhibition"
        event_dates = event_date_string.split(" – ")

        start_date = parse_date(event_dates[0], date_format)
        end_date = event_dates[-1] ? parse_date(event_dates[-1], date_format) : start_date

        { start_date: start_date, end_date: end_date }
      end
    end
  end
end
