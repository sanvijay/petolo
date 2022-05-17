require 'rails_helper'

RSpec.describe "events/show", type: :view do
  before(:each) do
    @event = assign(:event, Event.create!(
      slug: "Slug",
      title: "Title",
      description: "MyText",
      location: "Location",
      event_link: "Event Link",
      source: "Source"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Slug/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Location/)
    expect(rendered).to match(/Event Link/)
    expect(rendered).to match(/Source/)
  end
end
