require 'test_helper'

class RideTest < ActiveSupport::TestCase
	test 'cannot create ride without user' do
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
end
