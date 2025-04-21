require "test_helper"

class InstalledSoftwaresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @installed_software = installed_softwares(:one)
  end

  test "should get index" do
    get installed_softwares_url
    assert_response :success
  end

  test "should get new" do
    get new_installed_software_url
    assert_response :success
  end

  test "should create installed_software" do
    assert_difference("InstalledSoftware.count") do
      post installed_softwares_url, params: { installed_software: { finish_date: @installed_software.finish_date, name: @installed_software.name, start_date: @installed_software.start_date, version: @installed_software.version } }
    end

    assert_redirected_to installed_software_url(InstalledSoftware.last)
  end

  test "should show installed_software" do
    get installed_software_url(@installed_software)
    assert_response :success
  end

  test "should get edit" do
    get edit_installed_software_url(@installed_software)
    assert_response :success
  end

  test "should update installed_software" do
    patch installed_software_url(@installed_software), params: { installed_software: { finish_date: @installed_software.finish_date, name: @installed_software.name, start_date: @installed_software.start_date, version: @installed_software.version } }
    assert_redirected_to installed_software_url(@installed_software)
  end

  test "should destroy installed_software" do
    assert_difference("InstalledSoftware.count", -1) do
      delete installed_software_url(@installed_software)
    end

    assert_redirected_to installed_softwares_url
  end
end
