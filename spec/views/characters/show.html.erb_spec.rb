require 'rails_helper'

RSpec.describe "characters/show", type: :view do
  before(:each) do
    @character = assign(:character, Character.create!(
      name: "Name",
      marvel_uuid: "Marvel Uuid",
      description: "",
      picture_url: "Picture Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Marvel Uuid/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Picture Url/)
  end
end
