class Ride < ApplicationRecord
	belongs_to :user
	validates :user_id, presence: true

	def self.favourite_places(user)
		if Ride.where(user_id: user.id)
			rides = Ride.where(user_id: user.id)
			locations = {start: [], end: [], ride: []}
		end

		rides.each do |ride|
			if ride.ride_favourite
				locations[:ride].push({start: ride.start_address, end: ride.end_address})
			elsif ride.end_favourite
				locations[:end].push(ride.end_address)

			elsif ride.start_favourite
				locations[:start].push(ride.start_address)
				
			else 
				locations[:ride][:start].push('You have not chosen a favourite location!')
				locations[:ride][:end].push('You have not chosen a favourite location!') 
				locations[:end].push('You have not chosen a favourite location!')
				locations[:start].push('You have not chosen a favourite location!')
			end
		end
		return locations
	end
end
