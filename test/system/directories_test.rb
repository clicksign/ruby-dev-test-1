require "application_system_test_case"

class DirectoriesTest < ApplicationSystemTestCase
  setup do
    @directory = directories(:one)
  end

  test "visiting the index" do
    visit directories_url
    assert_selector "h1", text: "Directories"
  end

  test "should create directory" do
    visit directories_url
    click_on "New directory"

    fill_in "Name", with: @directory.name
    click_on "Create Directory"

    assert_text "Directory was successfully created"
    click_on "Back"
  end

  test "should update Directory" do
    visit directory_url(@directory)
    click_on "Edit this directory", match: :first

    fill_in "Name", with: @directory.name
    click_on "Update Directory"

    assert_text "Directory was successfully updated"
    click_on "Back"
  end

  test "should destroy Directory" do
    visit directory_url(@directory)
    click_on "Destroy this directory", match: :first

    assert_text "Directory was successfully destroyed"
  end
end
