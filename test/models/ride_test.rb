require 'test_helper'

class RideTest < ActiveSupport::TestCase
	test 'cannot_create_ride_without_user' do
		ride = Ride.new
		ride.latitude_start = 12
		ride.longitude_start = 1212
		ride.latitude_end = 12
		ride.longitude_end = 12
		ride.provider = 'uber'
		ride.price = 12
		ride.user_id = ''
		ride.start_address = 'some address'
		ride.end_address = 'address'
		ride.save
		assert_equal(true, ride.errors.any?)
	end

	test 'return_start_location_favourite_for_user' do
		user = User.new(first_name: 'bob', last_name: 'sagat', email: 'bob@sagat.com', password_digest: '12ewaglkfaer')
		ride = Ride.new(latitude_start: 12, longitude_start: 12.4, latitude_end: 11, longitude_end: 14, provider: 'uber', price: 123.4, user_id: user.id, start_address: 'some place', end_address: 'narnia', start_favourite: true)
		
	end
end
