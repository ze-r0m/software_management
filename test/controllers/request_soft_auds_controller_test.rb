require "test_helper"

class RequestSoftAudsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @request_soft_aud = request_soft_auds(:one)
  end

  test "should get index" do
    get request_soft_auds_url
    assert_response :success
  end

  test "should get new" do
    get new_request_soft_aud_url
    assert_response :success
  end

  test "should create request_soft_aud" do
    assert_difference("RequestSoftAud.count") do
      post request_soft_auds_url, params: { request_soft_aud: { comp_class_id: @request_soft_aud.comp_class_id, request_soft_id: @request_soft_aud.request_soft_id } }
    end

    assert_redirected_to request_soft_aud_url(RequestSoftAud.last)
  end

  test "should show request_soft_aud" do
    get request_soft_aud_url(@request_soft_aud)
    assert_response :success
  end

  test "should get edit" do
    get edit_request_soft_aud_url(@request_soft_aud)
    assert_response :success
  end

  test "should update request_soft_aud" do
    patch request_soft_aud_url(@request_soft_aud), params: { request_soft_aud: { comp_class_id: @request_soft_aud.comp_class_id, request_soft_id: @request_soft_aud.request_soft_id } }
    assert_redirected_to request_soft_aud_url(@request_soft_aud)
  end

  test "should destroy request_soft_aud" do
    assert_difference("RequestSoftAud.count", -1) do
      delete request_soft_aud_url(@request_soft_aud)
    end

    assert_redirected_to request_soft_auds_url
  end
end
