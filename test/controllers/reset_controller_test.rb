require 'test_helper'

class ResetControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get pass_reset_path
    assert_response :success
  end

  test "should get new" do
    get new_resets_path
    assert_response :success
  end

  test "should get create" do
    skip
    get reset_url
    assert_response :success
  end

end
