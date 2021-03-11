require 'rails_helper'

RSpec.describe "characters/edit", type: :view do
  before(:each) do
    @character = assign(:character, Character.create!(
      name: "MyString",
      marvel_uuid: "MyString",
      description: "",
      picture_url: "MyString"
    ))
  end

  it "renders the edit character form" do
    render

    assert_select "form[action=?][method=?]", character_path(@character), "post" do

      assert_select "input[name=?]", "character[name]"

      assert_select "input[name=?]", "character[marvel_uuid]"

      assert_select "input[name=?]", "character[description]"

      assert_select "input[name=?]", "character[picture_url]"
    end
  end
end
