# frozen_string_literal: true

module Events
  class CoBerlinProcessor < BaseProcessor
    def initialize
      super

      @source = "co_berlin"
      @domain = "https://co-berlin.org"
      @url = "#{domain}/en/program/calendar"
      @events = []
    end

    def process
      content.children.each do |child|
        next unless child.is_a?(Nokogiri::XML::Element) && child["class"] == "views-row"

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
        source: "co_berlin",
        event_link: domain + child.children.css("a")[0]["href"],
        title: child.css(".block-field-blocknodeeventtitle").text.strip,
        description: child.css(".block-field-blocknodeeventfield-subtitle").text.strip,
        start_date: event_dates[:start_date],
        end_date: event_dates[:end_date]
      }
    end

    def content
      return @content if @content

      fh = URI.parse(url).open
      html = fh.read
      parsed_data = Nokogiri::HTML.parse(html)

      @content = parsed_data.css(".view-content")
    end

    def parse_dates(child)
      event_date_string = child.css(".date-display-range").text
      event_dates = event_date_string.split(" – ")
      date_format = "%a, %b %d, %Y"

      start_date = parse_date(
        "#{event_dates[0]}, #{event_date_string[-4..]}",
        date_format
      )
      end_date = event_dates[1] ? parse_date(event_dates[1], date_format) : start_date

      { start_date: start_date, end_date: end_date }
    end
  end
end
