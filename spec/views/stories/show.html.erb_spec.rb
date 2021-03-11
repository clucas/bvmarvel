require 'rails_helper'

RSpec.describe "stories/show", type: :view do
  before(:each) do
    @story = assign(:story, Story.create!(
      title: "Title",
      marvel_uuid: "Marvel Uuid",
      description: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Marvel Uuid/)
    expect(rendered).to match(/MyText/)
  end
end
