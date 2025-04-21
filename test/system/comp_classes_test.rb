require "application_system_test_case"

class CompClassesTest < ApplicationSystemTestCase
  setup do
    @comp_class = comp_classes(:one)
  end

  test "visiting the index" do
    visit comp_classes_url
    assert_selector "h1", text: "Comp classes"
  end

  test "should create comp class" do
    visit comp_classes_url
    click_on "New comp class"

    fill_in "Add note", with: @comp_class.add_note
    fill_in "Aud number", with: @comp_class.aud_number
    fill_in "Cafedra", with: @comp_class.cafedra_id
    check "Ch board" if @comp_class.ch_board
    fill_in "Count comp", with: @comp_class.count_comp
    fill_in "Count comp seat", with: @comp_class.count_comp_seat
    fill_in "Count seat", with: @comp_class.count_seat
    check "Panel" if @comp_class.panel
    check "Projector" if @comp_class.projector
    fill_in "Spec purpose", with: @comp_class.spec_purpose
    click_on "Create Comp class"

    assert_text "Comp class was successfully created"
    click_on "Back"
  end

  test "should update Comp class" do
    visit comp_class_url(@comp_class)
    click_on "Edit this comp class", match: :first

    fill_in "Add note", with: @comp_class.add_note
    fill_in "Aud number", with: @comp_class.aud_number
    fill_in "Cafedra", with: @comp_class.cafedra_id
    check "Ch board" if @comp_class.ch_board
    fill_in "Count comp", with: @comp_class.count_comp
    fill_in "Count comp seat", with: @comp_class.count_comp_seat
    fill_in "Count seat", with: @comp_class.count_seat
    check "Panel" if @comp_class.panel
    check "Projector" if @comp_class.projector
    fill_in "Spec purpose", with: @comp_class.spec_purpose
    click_on "Update Comp class"

    assert_text "Comp class was successfully updated"
    click_on "Back"
  end

  test "should destroy Comp class" do
    visit comp_class_url(@comp_class)
    click_on "Destroy this comp class", match: :first

    assert_text "Comp class was successfully destroyed"
  end
end
