require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_user_path
    assert_response :success
  end
  
  test "should get create" do
    skip
    post user_path(user: {first_name: 'test', last_name: 'testing', email: 'testmail', password: 'pass', password_confirmation: 'pass', match: true})
    assert_response :success
  end
  
  test "should get show" do
    skip
    get user_path
    assert_response :success
  end

end
