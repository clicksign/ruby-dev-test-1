require "application_system_test_case"

class ArchivesTest < ApplicationSystemTestCase
  setup do
    @archive = archives(:one)
  end

  test "visiting the index" do
    visit archives_url
    assert_selector "h1", text: "Archives"
  end

  test "creating a Archive" do
    visit archives_url
    click_on "New Archive"

    fill_in "Name", with: @archive.name
    click_on "Create Archive"

    assert_text "Archive was successfully created"
    click_on "Back"
  end

  test "updating a Archive" do
    visit archives_url
    click_on "Edit", match: :first

    fill_in "Name", with: @archive.name
    click_on "Update Archive"

    assert_text "Archive was successfully updated"
    click_on "Back"
  end

  test "destroying a Archive" do
    visit archives_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Archive was successfully destroyed"
  end
end
