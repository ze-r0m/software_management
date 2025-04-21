require "application_system_test_case"

class RequestSoftsTest < ApplicationSystemTestCase
  setup do
    @request_soft = request_softs(:one)
  end

  test "visiting the index" do
    visit request_softs_url
    assert_selector "h1", text: "Request softs"
  end

  test "should create request soft" do
    visit request_softs_url
    click_on "New request soft"

    fill_in "Cafedra", with: @request_soft.cafedra_id
    fill_in "Contact", with: @request_soft.contact
    fill_in "Count", with: @request_soft.count
    fill_in "Price", with: @request_soft.price
    fill_in "Soft name", with: @request_soft.soft_name
    fill_in "Version", with: @request_soft.version
    click_on "Create Request soft"

    assert_text "Request soft was successfully created"
    click_on "Back"
  end

  test "should update Request soft" do
    visit request_soft_url(@request_soft)
    click_on "Edit this request soft", match: :first

    fill_in "Cafedra", with: @request_soft.cafedra_id
    fill_in "Contact", with: @request_soft.contact
    fill_in "Count", with: @request_soft.count
    fill_in "Price", with: @request_soft.price
    fill_in "Soft name", with: @request_soft.soft_name
    fill_in "Version", with: @request_soft.version
    click_on "Update Request soft"

    assert_text "Request soft was successfully updated"
    click_on "Back"
  end

  test "should destroy Request soft" do
    visit request_soft_url(@request_soft)
    click_on "Destroy this request soft", match: :first

    assert_text "Request soft was successfully destroyed"
  end
end
