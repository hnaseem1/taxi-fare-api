require 'test_helper'

class ResetTest < ActiveSupport::TestCase
	def setup
		user = User.new
		user.first_name = 'test'
		user.last_name = 'tester'
		user.email = 'testemail'
		user.password = 'pass'
		user.password_confirmation = 'pass'
		user.match = true
		user.save
		user
	end

	test 'user without token cannot reset password' do
		user = setup
		reset = Reset.new(user_id: 2, token: "sfhgjfdjf8")
		reset.save
		assert_not_equal(user.id, reset.user_id)
	end

	test 'tokens are can be exhausted' do

		user = setup
		reset1 = Reset.new(user_id: user.id, token: "sfhgjfdjf8")
		reset1.save
		reset1.token = "User Already Used This Token"
		reset1.save

		assert_equal(true, reset1.errors.any?)
	end

	test 'tokens are unique' do

		user = setup
		reset1 = Reset.new(user_id: user.id, token: "sfhgjfdjf8")
		reset1.save
		reset2  = Reset.new(user_id: user.id, token: "sfhgjfdjf8")
		reset2.save

		assert_equal(true, reset2.errors.any?)
	end

	test 'generate_reset_token method with valid user' do

		user = setup
		token = Reset.generate_reset_token(user)
		assert token

	end

	test 'verify_user_requested_reset method' do

		skip
		user = setup
		token = Reset.generate_reset_token(user)
		reset = Reset.new(user_id: user.id, token: token)
		reset.save
		response = Reset.verify_user_requested_reset(token)
		assert_equal(user, response)

	end

end
