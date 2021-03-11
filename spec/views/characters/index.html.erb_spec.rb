require 'rails_helper'

RSpec.describe "characters/index", type: :view do
  before(:each) do
    assign(:characters, [
      Character.create!(
        name: "Name",
        marvel_uuid: "Marvel Uuid",
        description: "",
        picture_url: "Picture Url"
      ),
      Character.create!(
        name: "Name",
        marvel_uuid: "Marvel Uuid",
        description: "",
        picture_url: "Picture Url"
      )
    ])
  end

  it "renders a list of characters" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Marvel Uuid".to_s, count: 2
    assert_select "tr>td", text: "".to_s, count: 2
    assert_select "tr>td", text: "Picture Url".to_s, count: 2
  end
end
