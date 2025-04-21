require "test_helper"

class ClassSoftwaresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @class_software = class_softwares(:one)
  end

  test "should get index" do
    get class_softwares_url
    assert_response :success
  end

  test "should get new" do
    get new_class_software_url
    assert_response :success
  end

  test "should create class_software" do
    assert_difference("ClassSoftware.count") do
      post class_softwares_url, params: { class_software: { comp_class_id: @class_software.comp_class_id, installed_software_id: @class_software.installed_software_id } }
    end

    assert_redirected_to class_software_url(ClassSoftware.last)
  end

  test "should show class_software" do
    get class_software_url(@class_software)
    assert_response :success
  end

  test "should get edit" do
    get edit_class_software_url(@class_software)
    assert_response :success
  end

  test "should update class_software" do
    patch class_software_url(@class_software), params: { class_software: { comp_class_id: @class_software.comp_class_id, installed_software_id: @class_software.installed_software_id } }
    assert_redirected_to class_software_url(@class_software)
  end

  test "should destroy class_software" do
    assert_difference("ClassSoftware.count", -1) do
      delete class_software_url(@class_software)
    end

    assert_redirected_to class_softwares_url
  end
end
