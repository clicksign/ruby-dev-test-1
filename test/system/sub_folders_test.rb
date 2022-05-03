require "application_system_test_case"

class SubFoldersTest < ApplicationSystemTestCase
  setup do
    @sub_folder = sub_folders(:one)
  end

  test "visiting the index" do
    visit sub_folders_url
    assert_selector "h1", text: "Sub folders"
  end

  test "should create sub folder" do
    visit sub_folders_url
    click_on "New sub folder"

    fill_in "Name", with: @sub_folder.name
    click_on "Create Sub folder"

    assert_text "Sub folder was successfully created"
    click_on "Back"
  end

  test "should update Sub folder" do
    visit sub_folder_url(@sub_folder)
    click_on "Edit this sub folder", match: :first

    fill_in "Name", with: @sub_folder.name
    click_on "Update Sub folder"

    assert_text "Sub folder was successfully updated"
    click_on "Back"
  end

  test "should destroy Sub folder" do
    visit sub_folder_url(@sub_folder)
    click_on "Destroy this sub folder", match: :first

    assert_text "Sub folder was successfully destroyed"
  end
end
