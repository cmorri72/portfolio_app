require 'rails_helper'

RSpec.describe "items/index", type: :view do
  before(:each) do
    assign(:items, [
      Item.create!(
        title: "Title",
        description: "MyText",
        price: "9.99",
        image: "Image"
      ),
      Item.create!(
        title: "Title",
        description: "MyText",
        price: "9.99",
        image: "Image"
      )
    ])
  end

  it "renders a list of items" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Title".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Image".to_s), count: 2
  end
end
