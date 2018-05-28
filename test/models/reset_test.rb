require 'test_helper'

class ResetTest < ActiveSupport::TestCase
	test 'user without token cannot reset password' do
		user = User.new
		user.first_name = 'test'
		user.last_name = 'tester'
		user.email = 'testemail'
		user.password = 'pass'
		user.password_confirmation = 'pass'
		user.match = true
		user.save

		reset = Reset.new(user_id: 2, token: "sfhgjfdjf8")
		reset.save
		assert_not_equal(user.id, reset.user_id)
	end

	test 'tokens are can be exhausted' do
		user = User.new
		user.first_name = 'test'
		user.last_name = 'tester'
		user.email = 'testemail'
		user.password = 'pass'
		user.password_confirmation = 'pass'
		user.match = true
		user.save

		reset1 = Reset.new(user_id: user.id, token: "sfhgjfdjf8")
		reset1.save
		reset1.token = "User Already Used This Token"
		reset1.save

		assert_equal(false, reset1.errors.any?)
	end

	test 'tokens are unique' do
		user = User.new
		user.first_name = 'test'
		user.last_name = 'tester'
		user.email = 'testemail'
		user.password = 'pass'
		user.password_confirmation = 'pass'
		user.match = true
		user.save

		reset1 = Reset.new(user_id: user.id, token: "sfhgjfdjf8")
		reset1.save
		reset2  = Reset.new(user_id: user.id, token: "sfhgjfdjf8")
		reset2.save

		assert_equal(true, reset2.errors.any?)
	end
end
