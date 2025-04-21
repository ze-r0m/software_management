require "application_system_test_case"

class RequestSoftAudsTest < ApplicationSystemTestCase
  setup do
    @request_soft_aud = request_soft_auds(:one)
  end

  test "visiting the index" do
    visit request_soft_auds_url
    assert_selector "h1", text: "Request soft auds"
  end

  test "should create request soft aud" do
    visit request_soft_auds_url
    click_on "New request soft aud"

    fill_in "Comp class", with: @request_soft_aud.comp_class_id
    fill_in "Request soft", with: @request_soft_aud.request_soft_id
    click_on "Create Request soft aud"

    assert_text "Request soft aud was successfully created"
    click_on "Back"
  end

  test "should update Request soft aud" do
    visit request_soft_aud_url(@request_soft_aud)
    click_on "Edit this request soft aud", match: :first

    fill_in "Comp class", with: @request_soft_aud.comp_class_id
    fill_in "Request soft", with: @request_soft_aud.request_soft_id
    click_on "Update Request soft aud"

    assert_text "Request soft aud was successfully updated"
    click_on "Back"
  end

  test "should destroy Request soft aud" do
    visit request_soft_aud_url(@request_soft_aud)
    click_on "Destroy this request soft aud", match: :first

    assert_text "Request soft aud was successfully destroyed"
  end
end
