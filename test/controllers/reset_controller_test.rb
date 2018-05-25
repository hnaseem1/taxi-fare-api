require 'test_helper'

class ResetControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get reset_show_url
    assert_response :success
  end

  test "should get new" do
    get reset_new_url
    assert_response :success
  end

  test "should get create" do
    get reset_create_url
    assert_response :success
  end

end
