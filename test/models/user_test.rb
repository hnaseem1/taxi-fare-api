require 'test_helper'

class UserTest < ActiveSupport::TestCase
	test 'create_user' do
		user = User.new
		user.first_name = 'test'
		user.last_name = 'tester'
		user.email = 'testemail@test.com'
		user.password = 'pass'
		user.password_confirmation = 'pass'
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

		user.save
		assert_equal(true, user.errors.any?)
	end

	test 'create_invalid_user_with_invalid_email' do
		user = User.new(first_name: 'test', last_name: 'tester', email: 'testmail', password: '123', password_confirmation: '123')
		user.save
		assert_equal(true, user.errors.any?)
	end


	test 'places_visited_returns_true' do
		user = User.new(first_name: 'test', last_name: 'tester', email: 'testmail@test.com', password: '123', password_confirmation: '123')

		user.save
		ride = Ride.new(latitude_start: 43.647432, longitude_start: -79.3870747, latitude_end: 53.5468538, longitude_end: -113.4913583, user_id: user.id, start_address: 'some addr', end_address: 'another addr')
		ride.save
		assert_equal('some addr', User.places_visited(user)[:start][0])
	end
end
