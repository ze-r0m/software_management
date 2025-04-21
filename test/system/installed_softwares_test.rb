require "application_system_test_case"

class InstalledSoftwaresTest < ApplicationSystemTestCase
  setup do
    @installed_software = installed_softwares(:one)
  end

  test "visiting the index" do
    visit installed_softwares_url
    assert_selector "h1", text: "Installed softwares"
  end

  test "should create installed software" do
    visit installed_softwares_url
    click_on "New installed software"

    fill_in "Finish date", with: @installed_software.finish_date
    fill_in "Name", with: @installed_software.name
    fill_in "Start date", with: @installed_software.start_date
    fill_in "Version", with: @installed_software.version
    click_on "Create Installed software"

    assert_text "Installed software was successfully created"
    click_on "Back"
  end

  test "should update Installed software" do
    visit installed_software_url(@installed_software)
    click_on "Edit this installed software", match: :first

    fill_in "Finish date", with: @installed_software.finish_date
    fill_in "Name", with: @installed_software.name
    fill_in "Start date", with: @installed_software.start_date
    fill_in "Version", with: @installed_software.version
    click_on "Update Installed software"

    assert_text "Installed software was successfully updated"
    click_on "Back"
  end

  test "should destroy Installed software" do
    visit installed_software_url(@installed_software)
    click_on "Destroy this installed software", match: :first

    assert_text "Installed software was successfully destroyed"
  end
end
