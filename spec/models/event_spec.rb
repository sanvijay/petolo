# frozen_string_literal: true

require "rails_helper"

RSpec.describe Event, type: :model do
  let(:valid_attr) do
    {
      title: "STRETCH YOUR CREATIVE MUSCLES",
      description: "International live online photography workshop in six sessions",
      start_date: Time.zone.now,
      end_date: Time.zone.now + 2.days
    }
  end
  let(:event)    { described_class.new(valid_attr) }

  it "is a valid event" do
    expect(event).to be_valid
  end

  it "does not allow empty / blank title" do
    event.title = "     "
    expect(event).not_to be_valid
  end

  it "does not allow empty value for description" do
    event.description = "     "
    expect(event).not_to be_valid
  end

  it "does not allow end_date before start_date" do
    event.end_date = event.start_date - 2.days
    expect(event).not_to be_valid
  end
end
