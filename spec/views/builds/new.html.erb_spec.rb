require 'rails_helper'

RSpec.describe "builds/new", type: :view do
  before(:each) do
    assign(:build, Build.new(
      email: "MyString",
      active: false,
      summary: "MyText",
      skills: "MyText",
      customer: nil
    ))
  end

  it "renders new build form" do
    render

    assert_select "form[action=?][method=?]", builds_path, "post" do

      assert_select "input[name=?]", "build[email]"

      assert_select "input[name=?]", "build[active]"

      assert_select "textarea[name=?]", "build[summary]"

      assert_select "textarea[name=?]", "build[skills]"

      assert_select "input[name=?]", "build[customer_id]"
    end
  end
end
