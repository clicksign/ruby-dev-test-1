require 'rails_helper'

RSpec.describe "folders/edit", type: :view do
  before(:each) do
    @folder = assign(:folder, Folder.create!(
      name: "MyString"
    ))
  end

  it "renders the edit folder form" do
    render

    assert_select "form[action=?][method=?]", folder_path(@folder), "post" do

      assert_select "input[name=?]", "folder[name]"
    end
  end
end
