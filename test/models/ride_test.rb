require 'test_helper'

class RideTest < ActiveSupport::TestCase

	setup do
		@user = User.new(first_name: 'bob', last_name: 'sagat', email: 'bob@sagat.com', password: 'testtest', password_confirmation: 'testtest')
		@user.save
		@ride = Ride.new
		@ride.latitude_start = 12
		@ride.longitude_start = 1212
		@ride.latitude_end = 12
		@ride.longitude_end = 12
		@ride.provider = 'uber'
		@ride.price = 12
		@ride.user_id = @user.id
		@ride.start_address = 'start address'
		@ride.end_address = 'end address'
		@ride.start_favourite = nil
		@ride.end_favourite = nil
		@ride.created_at = Time.now
		@ride.save



		@user1 = User.new(first_name: 'bobert', last_name: 'sagert', email: 'bob@sagertt.com', password: 'testtest', password_confirmation: 'testtest')
		@user1.save
		@ride1 = Ride.new
		@ride1.latitude_start = 12
		@ride1.longitude_start = 1212
		@ride1.latitude_end = 12
		@ride1.longitude_end = 12
		@ride1.provider = 'uber'
		@ride1.price = 12
		@ride1.user_id = @user1.id
		@ride1.start_address = 'start address'
		@ride1.end_address = 'end address'
		@ride1.start_favourite = nil
		@ride1.end_favourite = nil
		@ride1.created_at = Time.now
		@ride1.save	
	end

	test 'ride in setup must be valid' do
		assert_not_nil(@ride)
		assert_not_nil(@ride.id)
	end

	test 'cannot_create_ride_without_user' do
		@ride.user_id = nil
		refute(@ride.valid?)
	end

	test 'favourite_places_should_return_a_populated_hash_if_the_user_has_favorite_rides' do
		@ride.start_favourite = true
		@ride.save		
		assert_equal(1, @user.rides.count)
		assert_equal(true, Ride.favourite_places(@user).is_a?(Hash))
		assert_equal('start address', Ride.favourite_places(@user)[:start][0])
	end

	test 'favorite_places_should_return_false_if_user_has_no_rides' do
	end

	test 'return_start_location_if_ride_is_a_favourite_for_user' do
		@ride.start_favourite = true
		@ride.save
		assert_equal('start address', Ride.favourite_places(@user)[:start][0])
	end

	test 'return_end_location_if_ride_is_a_favourite_for_user' do
		@ride.end_favourite = true
		@ride.save		
		assert_equal('end address', Ride.favourite_places(@user)[:end][0])
	end


	test 'return multiple start and end locations if user has multiple favourites' do
		@ride.ride_favourite = true
		@ride.save
		new_ride = Ride.new(latitude_start: 12, longitude_start: 1231, latitude_end: 123114, longitude_end: 2234, provider: 'lyft', price: 2341, user_id: @user.id, start_address: 'startgint place', end_address: 'ending place', ride_favourite: true)
		new_ride.save
		assert_equal(2 , Ride.favourite_places(@user)[:ride].count)
	end

	test 'return users that are going to the same location' do
		rides = Ride.companions('start address', 'end address')
		random_person = User.create(first_name: 'random', last_name: 'randomness', email: 'random@randomness.com', password: 'pass', password_confirmation: 'pass')
		random_ride = Ride.create(latitude_start: 12, longitude_start: 1231, latitude_end: 123114, longitude_end: 2234, provider: 'lyft', price: 2341, user_id: random_person.id, start_address: 'startgint place', end_address: 'ending place', ride_favourite: true)
	
		assert_equal(['bob@sagat.com', 'bob@sagertt.com'], Ride.companions('start address', 'end address'))
	end
end
