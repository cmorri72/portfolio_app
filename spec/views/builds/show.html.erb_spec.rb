require 'rails_helper'

RSpec.describe "builds/show", type: :view do
  before(:each) do
    assign(:build, Build.create!(
      email: "Email",
      active: false,
      summary: "MyText",
      skills: "MyText",
      customer: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
