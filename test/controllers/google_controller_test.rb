require 'test_helper'

class GoogleControllerTest < ActionDispatch::IntegrationTest
  test "get index" do
  	get google_path
  	assert_response :success
  end

  test "get root" do 
  	get root_path 
  	assert_response :success
  end
end
