require 'rails_helper'

RSpec.describe "folders/show", type: :view do
  before(:each) do
    @folder = assign(:folder, Folder.create!(
      name: "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
