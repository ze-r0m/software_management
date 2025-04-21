require "test_helper"

class CafedrasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cafedra = cafedras(:one)
  end

  test "should get index" do
    get cafedras_url
    assert_response :success
  end

  test "should get new" do
    get new_cafedra_url
    assert_response :success
  end

  test "should create cafedra" do
    assert_difference("Cafedra.count") do
      post cafedras_url, params: { cafedra: { add_note: @cafedra.add_note, faculty_id: @cafedra.faculty_id, name: @cafedra.name } }
    end

    assert_redirected_to cafedra_url(Cafedra.last)
  end

  test "should show cafedra" do
    get cafedra_url(@cafedra)
    assert_response :success
  end

  test "should get edit" do
    get edit_cafedra_url(@cafedra)
    assert_response :success
  end

  test "should update cafedra" do
    patch cafedra_url(@cafedra), params: { cafedra: { add_note: @cafedra.add_note, faculty_id: @cafedra.faculty_id, name: @cafedra.name } }
    assert_redirected_to cafedra_url(@cafedra)
  end

  test "should destroy cafedra" do
    assert_difference("Cafedra.count", -1) do
      delete cafedra_url(@cafedra)
    end

    assert_redirected_to cafedras_url
  end
end
