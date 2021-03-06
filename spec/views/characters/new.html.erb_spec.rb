require 'rails_helper'

RSpec.describe "characters/new", type: :view do
  before(:each) do
    assign(:character, Character.new(
      name: "MyString",
      marvel_uuid: "MyString",
      description: "",
      picture_url: "MyString"
    ))
  end

  it "renders new character form" do
    render

    assert_select "form[action=?][method=?]", characters_path, "post" do

      assert_select "input[name=?]", "character[name]"

      assert_select "input[name=?]", "character[marvel_uuid]"

      assert_select "input[name=?]", "character[description]"

      assert_select "input[name=?]", "character[picture_url]"
    end
  end
end
