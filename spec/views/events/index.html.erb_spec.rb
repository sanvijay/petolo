require 'rails_helper'

RSpec.describe "events/index", type: :view do
  before(:each) do
    assign(:events, [
      Event.create!(
        slug: "Slug",
        title: "Title",
        description: "MyText",
        location: "Location",
        event_link: "Event Link",
        source: "Source"
      ),
      Event.create!(
        slug: "Slug",
        title: "Title",
        description: "MyText",
        location: "Location",
        event_link: "Event Link",
        source: "Source"
      )
    ])
  end

  it "renders a list of events" do
    render
    assert_select "tr>td", text: "Slug".to_s, count: 2
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: "Location".to_s, count: 2
    assert_select "tr>td", text: "Event Link".to_s, count: 2
    assert_select "tr>td", text: "Source".to_s, count: 2
  end
end
