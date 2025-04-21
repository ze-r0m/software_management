require "test_helper"

class AcultiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @aculty = aculties(:one)
  end

  test "should get index" do
    get aculties_url
    assert_response :success
  end

  test "should get new" do
    get new_aculty_url
    assert_response :success
  end

  test "should create aculty" do
    assert_difference("Aculty.count") do
      post aculties_url, params: { aculty: { add_note: @aculty.add_note, name: @aculty.name } }
    end

    assert_redirected_to aculty_url(Aculty.last)
  end

  test "should show aculty" do
    get aculty_url(@aculty)
    assert_response :success
  end

  test "should get edit" do
    get edit_aculty_url(@aculty)
    assert_response :success
  end

  test "should update aculty" do
    patch aculty_url(@aculty), params: { aculty: { add_note: @aculty.add_note, name: @aculty.name } }
    assert_redirected_to aculty_url(@aculty)
  end

  test "should destroy aculty" do
    assert_difference("Aculty.count", -1) do
      delete aculty_url(@aculty)
    end

    assert_redirected_to aculties_url
  end
end
