require "application_system_test_case"

class AcultiesTest < ApplicationSystemTestCase
  setup do
    @aculty = aculties(:one)
  end

  test "visiting the index" do
    visit aculties_url
    assert_selector "h1", text: "Aculties"
  end

  test "should create aculty" do
    visit aculties_url
    click_on "New aculty"

    fill_in "Add note", with: @aculty.add_note
    fill_in "Name", with: @aculty.name
    click_on "Create Aculty"

    assert_text "Aculty was successfully created"
    click_on "Back"
  end

  test "should update Aculty" do
    visit aculty_url(@aculty)
    click_on "Edit this aculty", match: :first

    fill_in "Add note", with: @aculty.add_note
    fill_in "Name", with: @aculty.name
    click_on "Update Aculty"

    assert_text "Aculty was successfully updated"
    click_on "Back"
  end

  test "should destroy Aculty" do
    visit aculty_url(@aculty)
    click_on "Destroy this aculty", match: :first

    assert_text "Aculty was successfully destroyed"
  end
end
