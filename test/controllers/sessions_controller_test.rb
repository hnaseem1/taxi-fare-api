require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_sessions_path
    assert_response :success
  end
  
  test "should get create" do
    
    post sessions_path(session: {email: 'Tester', password: 'pass'})
    assert_response :success
  end
  #
  test "should get destroy" do
    skip
    delete sessions_path
    assert_response :success
  end

end
