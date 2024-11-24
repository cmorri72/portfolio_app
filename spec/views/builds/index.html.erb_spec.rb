require 'rails_helper'

RSpec.describe "builds/index", type: :view do
  before(:each) do
    assign(:builds, [
      Build.create!(
        email: "Email",
        active: false,
        summary: "MyText",
        skills: "MyText",
        customer: nil
      ),
      Build.create!(
        email: "Email",
        active: false,
        summary: "MyText",
        skills: "MyText",
        customer: nil
      )
    ])
  end

  it "renders a list of builds" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Email".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
