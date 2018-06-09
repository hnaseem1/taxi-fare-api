class Ride < ApplicationRecord

	belongs_to :user
	validates :user_id, :start_address, :end_address, presence: true

	def self.favourite_places(user)
		if Ride.where(user_id: user.id)
			rides = Ride.where(user_id: user.id)
			unless rides.empty?
				locations = {start: [], end: [], ride: []}
				rides.each do |ride|
					if ride.ride_favourite
						locations[:ride].push({start: ride.start_address, end: ride.end_address})
					elsif ride.end_favourite
						locations[:end].push(ride.end_address)

					elsif ride.start_favourite
						locations[:start].push(ride.start_address)
					end
				end
				return locations
			end
		end
		return false
	end

	def self.companions(new_ride_start_address, new_ride_end_address)
		time_now = Time.now
		time_limit = Time.now - 5.minutes
		#get current time and get all the users who have searched for rides in the last 30 minutes
		recent_rides = Ride.where(created_at: time_limit..time_now, start_address: new_ride_start_address, end_address: new_ride_end_address)

		companions = []
			if recent_rides.count > 0
				recent_rides.each do |ride|
					companions.push(User.find(ride.user_id).email)
				end
			elsif recent_rides.count == 0 
				return false
			end

				return companions
	end
end
