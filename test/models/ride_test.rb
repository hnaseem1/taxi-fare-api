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
		user.save
		ride = Ride.new(latitude_start: 12, longitude_start: 12.4, latitude_end: 11, longitude_end: 14, provider: 'uber', price: 123.4, user_id: user.id, start_address: 'some place', end_address: 'narnia', start_favourite: true)
		ride.save
		assert_equal('some place', Ride.favourite_places(user)[:start][0])
	end
	test 'return_end_location_favourite_for_user' do
		
		user = User.new(first_name: 'bob', last_name: 'sagat', email: 'bob@sagat.com', password_digest: '12ewaglkfaer')
		user.save
		ride = Ride.new(latitude_start: 12, longitude_start: 12.4, latitude_end: 11, longitude_end: 14, provider: 'uber', price: 123.4, user_id: user.id, start_address: 'some place', end_address: 'narnia', start_favourite: false, end_favourite: true)
		ride.save
		assert_equal('narnia', Ride.favourite_places(user)[:end][0])
	end

	test 'return_ride_favourite_start_location_for_user' do
		
		user = User.new(first_name: 'bob', last_name: 'sagat', email: 'bob@sagat.com', password_digest: '12ewaglkfaer')
		user.save
		ride = Ride.new(latitude_start: 12, longitude_start: 12.4, latitude_end: 11, longitude_end: 14, provider: 'uber', price: 123.4, user_id: user.id, start_address: 'some place', end_address: 'narnia', start_favourite: false, end_favourite: false, ride_favourite: true)
		ride.save
		assert_equal('some place', Ride.favourite_places(user)[:ride][:start][0])
	end

	test 'return_ride_favourite_end_location_for_user' do
		
		user = User.new(first_name: 'bob', last_name: 'sagat', email: 'bob@sagat.com', password_digest: '12ewaglkfaer')
		user.save
		ride = Ride.new(latitude_start: 12, longitude_start: 12.4, latitude_end: 11, longitude_end: 14, provider: 'uber', price: 123.4, user_id: user.id, start_address: 'some place', end_address: 'narnia', start_favourite: false, end_favourite: false, ride_favourite: true)
		ride.save
		assert_equal('narnia', Ride.favourite_places(user)[:ride][:end][0])
	end

	test 'return_3_ride_favourite_end_locations_for_user' do
		
		user = User.new(first_name: 'bob', last_name: 'sagat', email: 'bob@sagat.com', password_digest: '12ewaglkfaer')
		user.save
		ride = Ride.new(latitude_start: 12, longitude_start: 12.4, latitude_end: 11, longitude_end: 14, provider: 'uber', price: 123.4, user_id: user.id, start_address: 'some place', end_address: 'narnia', start_favourite: false, end_favourite: false, ride_favourite: true)
		ride1 = Ride.new(latitude_start: 12, longitude_start: 12.4, latitude_end: 11, longitude_end: 14, provider: 'uber', price: 123.4, user_id: user.id, start_address: 'some place', end_address: 'narniaa', start_favourite: false, end_favourite: false, ride_favourite: true)
		ride2 = Ride.new(latitude_start: 12, longitude_start: 12.4, latitude_end: 11, longitude_end: 14, provider: 'uber', price: 123.4, user_id: user.id, start_address: 'some place', end_address: 'narniaaa', start_favourite: false, end_favourite: false, ride_favourite: true)
		ride2.save
		ride1.save
		ride.save
		assert_equal(3 , Ride.favourite_places(user)[:ride][:end].count)
	end
end
