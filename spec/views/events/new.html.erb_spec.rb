require 'rails_helper'

RSpec.describe "events/new", type: :view do
  before(:each) do
    assign(:event, Event.new(
      slug: "MyString",
      title: "MyString",
      description: "MyText",
      location: "MyString",
      event_link: "MyString",
      source: "MyString"
    ))
  end

  it "renders new event form" do
    render

    assert_select "form[action=?][method=?]", events_path, "post" do

      assert_select "input[name=?]", "event[slug]"

      assert_select "input[name=?]", "event[title]"

      assert_select "textarea[name=?]", "event[description]"

      assert_select "input[name=?]", "event[location]"

      assert_select "input[name=?]", "event[event_link]"

      assert_select "input[name=?]", "event[source]"
    end
  end
end
