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

end
