require "application_system_test_case"

class FoldersTest < ApplicationSystemTestCase
  setup do
    @folder = folders(:one)
  end

  test "visiting the index" do
    visit folders_url
    assert_selector "h1", text: "Folders"
  end

  test "should create folder" do
    visit folders_url
    click_on "New folder"

    fill_in "Name", with: @folder.name
    fill_in "Parent folder", with: @folder.parent_folder_id
    click_on "Create Folder"

    assert_text "Folder was successfully created"
    click_on "Back"
  end

  test "should update Folder" do
    visit folder_url(@folder)
    click_on "Edit this folder", match: :first

    fill_in "Name", with: @folder.name
    fill_in "Parent folder", with: @folder.parent_folder_id
    click_on "Update Folder"

    assert_text "Folder was successfully updated"
    click_on "Back"
  end

  test "should destroy Folder" do
    visit folder_url(@folder)
    click_on "Destroy this folder", match: :first

    assert_text "Folder was successfully destroyed"
  end
end
