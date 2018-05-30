class User < ApplicationRecord
	has_secure_password
	has_many :rides
	has_many :resets
	
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, presence: true, uniqueness: true
	# regex for validating the format of an email
	validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

	def self.places_visited(user)
		locations = {start: [], end: []}
		taken_rides = user.rides
		taken_rides.each do |obj|
			locations[:start].push(obj.start_address)
			locations[:end].push(obj.end_address)
		end
		return locations
	end


end
