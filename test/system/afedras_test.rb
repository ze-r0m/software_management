require "application_system_test_case"

class AfedrasTest < ApplicationSystemTestCase
  setup do
    @afedra = afedras(:one)
  end

  test "visiting the index" do
    visit afedras_url
    assert_selector "h1", text: "Afedras"
  end

  test "should create afedra" do
    visit afedras_url
    click_on "New afedra"

    fill_in "Add note", with: @afedra.add_note
    fill_in "Faculty", with: @afedra.faculty_id
    fill_in "Name", with: @afedra.name
    click_on "Create Afedra"

    assert_text "Afedra was successfully created"
    click_on "Back"
  end

  test "should update Afedra" do
    visit afedra_url(@afedra)
    click_on "Edit this afedra", match: :first

    fill_in "Add note", with: @afedra.add_note
    fill_in "Faculty", with: @afedra.faculty_id
    fill_in "Name", with: @afedra.name
    click_on "Update Afedra"

    assert_text "Afedra was successfully updated"
    click_on "Back"
  end

  test "should destroy Afedra" do
    visit afedra_url(@afedra)
    click_on "Destroy this afedra", match: :first

    assert_text "Afedra was successfully destroyed"
  end
end
