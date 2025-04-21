require "application_system_test_case"

class ClassSoftwaresTest < ApplicationSystemTestCase
  setup do
    @class_software = class_softwares(:one)
  end

  test "visiting the index" do
    visit class_softwares_url
    assert_selector "h1", text: "Class softwares"
  end

  test "should create class software" do
    visit class_softwares_url
    click_on "New class software"

    fill_in "Comp class", with: @class_software.comp_class_id
    fill_in "Installed software", with: @class_software.installed_software_id
    click_on "Create Class software"

    assert_text "Class software was successfully created"
    click_on "Back"
  end

  test "should update Class software" do
    visit class_software_url(@class_software)
    click_on "Edit this class software", match: :first

    fill_in "Comp class", with: @class_software.comp_class_id
    fill_in "Installed software", with: @class_software.installed_software_id
    click_on "Update Class software"

    assert_text "Class software was successfully updated"
    click_on "Back"
  end

  test "should destroy Class software" do
    visit class_software_url(@class_software)
    click_on "Destroy this class software", match: :first

    assert_text "Class software was successfully destroyed"
  end
end
