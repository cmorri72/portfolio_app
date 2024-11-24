require 'rails_helper'

RSpec.describe "builds/edit", type: :view do
  let(:build) {
    Build.create!(
      email: "MyString",
      active: false,
      summary: "MyText",
      skills: "MyText",
      customer: nil
    )
  }

  before(:each) do
    assign(:build, build)
  end

  it "renders the edit build form" do
    render

    assert_select "form[action=?][method=?]", build_path(build), "post" do

      assert_select "input[name=?]", "build[email]"

      assert_select "input[name=?]", "build[active]"

      assert_select "textarea[name=?]", "build[summary]"

      assert_select "textarea[name=?]", "build[skills]"

      assert_select "input[name=?]", "build[customer_id]"
    end
  end
end
