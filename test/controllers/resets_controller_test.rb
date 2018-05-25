require 'test_helper'

class ResetsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get pass_reset_path
    assert_response :success
  end

  test "should get new" do
    get new_resets_path
    assert_response :success
  end

  test "should get create" do
    post resets_path(reset: {email: 'someemail'})
    assert_response :success
  end

end
