require "application_system_test_case"

class CafedrasTest < ApplicationSystemTestCase
  setup do
    @cafedra = cafedras(:one)
  end

  test "visiting the index" do
    visit cafedras_url
    assert_selector "h1", text: "Cafedras"
  end

  test "should create cafedra" do
    visit cafedras_url
    click_on "New cafedra"

    fill_in "Add note", with: @cafedra.add_note
    fill_in "Faculty", with: @cafedra.faculty_id
    fill_in "Name", with: @cafedra.name
    click_on "Create Cafedra"

    assert_text "Cafedra was successfully created"
    click_on "Back"
  end

  test "should update Cafedra" do
    visit cafedra_url(@cafedra)
    click_on "Edit this cafedra", match: :first

    fill_in "Add note", with: @cafedra.add_note
    fill_in "Faculty", with: @cafedra.faculty_id
    fill_in "Name", with: @cafedra.name
    click_on "Update Cafedra"

    assert_text "Cafedra was successfully updated"
    click_on "Back"
  end

  test "should destroy Cafedra" do
    visit cafedra_url(@cafedra)
    click_on "Destroy this cafedra", match: :first

    assert_text "Cafedra was successfully destroyed"
  end
end
