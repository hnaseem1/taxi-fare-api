require 'test_helper'

class UserTest < ActiveSupport::TestCase
	test 'create user' do
		user = User.new
		user.first_name = 'test'
		user.last_name = 'tester'
		user.email = 'testemail'
		user.password = 'pass'
		user.password_confirmation = 'pass'
		user.match = true
		user.save
		assert_equal(false, user.errors.any?)
	end

	test 'create_invalid_user' do
		user = User.new
		user.first_name = ''
		user.last_name = 'tester'
		user.email = 'testemail'
		user.password = 'pass'
		user.password_confirmation = 'pass'
		user.match = true
		user.save
		assert_equal(true, user.errors.any?)
	end
end
