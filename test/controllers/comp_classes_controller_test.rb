require "test_helper"

class CompClassesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comp_class = comp_classes(:one)
  end

  test "should get index" do
    get comp_classes_url
    assert_response :success
  end

  test "should get new" do
    get new_comp_class_url
    assert_response :success
  end

  test "should create comp_class" do
    assert_difference("CompClass.count") do
      post comp_classes_url, params: { comp_class: { add_note: @comp_class.add_note, aud_number: @comp_class.aud_number, cafedra_id: @comp_class.cafedra_id, ch_board: @comp_class.ch_board, count_comp: @comp_class.count_comp, count_comp_seat: @comp_class.count_comp_seat, count_seat: @comp_class.count_seat, panel: @comp_class.panel, projector: @comp_class.projector, spec_purpose: @comp_class.spec_purpose } }
    end

    assert_redirected_to comp_class_url(CompClass.last)
  end

  test "should show comp_class" do
    get comp_class_url(@comp_class)
    assert_response :success
  end

  test "should get edit" do
    get edit_comp_class_url(@comp_class)
    assert_response :success
  end

  test "should update comp_class" do
    patch comp_class_url(@comp_class), params: { comp_class: { add_note: @comp_class.add_note, aud_number: @comp_class.aud_number, cafedra_id: @comp_class.cafedra_id, ch_board: @comp_class.ch_board, count_comp: @comp_class.count_comp, count_comp_seat: @comp_class.count_comp_seat, count_seat: @comp_class.count_seat, panel: @comp_class.panel, projector: @comp_class.projector, spec_purpose: @comp_class.spec_purpose } }
    assert_redirected_to comp_class_url(@comp_class)
  end

  test "should destroy comp_class" do
    assert_difference("CompClass.count", -1) do
      delete comp_class_url(@comp_class)
    end

    assert_redirected_to comp_classes_url
  end
end
