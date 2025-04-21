require "test_helper"

class RequestSoftsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @request_soft = request_softs(:one)
  end

  test "should get index" do
    get request_softs_url
    assert_response :success
  end

  test "should get new" do
    get new_request_soft_url
    assert_response :success
  end

  test "should create request_soft" do
    assert_difference("RequestSoft.count") do
      post request_softs_url, params: { request_soft: { cafedra_id: @request_soft.cafedra_id, contact: @request_soft.contact, count: @request_soft.count, price: @request_soft.price, soft_name: @request_soft.soft_name, version: @request_soft.version } }
    end

    assert_redirected_to request_soft_url(RequestSoft.last)
  end

  test "should show request_soft" do
    get request_soft_url(@request_soft)
    assert_response :success
  end

  test "should get edit" do
    get edit_request_soft_url(@request_soft)
    assert_response :success
  end

  test "should update request_soft" do
    patch request_soft_url(@request_soft), params: { request_soft: { cafedra_id: @request_soft.cafedra_id, contact: @request_soft.contact, count: @request_soft.count, price: @request_soft.price, soft_name: @request_soft.soft_name, version: @request_soft.version } }
    assert_redirected_to request_soft_url(@request_soft)
  end

  test "should destroy request_soft" do
    assert_difference("RequestSoft.count", -1) do
      delete request_soft_url(@request_soft)
    end

    assert_redirected_to request_softs_url
  end
end
