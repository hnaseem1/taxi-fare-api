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
end
