require "test_helper"

class AfedrasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @afedra = afedras(:one)
  end

  test "should get index" do
    get afedras_url
    assert_response :success
  end

  test "should get new" do
    get new_afedra_url
    assert_response :success
  end

  test "should create afedra" do
    assert_difference("Afedra.count") do
      post afedras_url, params: { afedra: { add_note: @afedra.add_note, faculty_id: @afedra.faculty_id, name: @afedra.name } }
    end

    assert_redirected_to afedra_url(Afedra.last)
  end

  test "should show afedra" do
    get afedra_url(@afedra)
    assert_response :success
  end

  test "should get edit" do
    get edit_afedra_url(@afedra)
    assert_response :success
  end

  test "should update afedra" do
    patch afedra_url(@afedra), params: { afedra: { add_note: @afedra.add_note, faculty_id: @afedra.faculty_id, name: @afedra.name } }
    assert_redirected_to afedra_url(@afedra)
  end

  test "should destroy afedra" do
    assert_difference("Afedra.count", -1) do
      delete afedra_url(@afedra)
    end

    assert_redirected_to afedras_url
  end
end
