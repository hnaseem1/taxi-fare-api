module UsersHelper
	def show_start_favs(data)
		return data[:start]
	end

	def show_end_favs(data)
		return data[:end]
	end

	def show_ride_favs(data)
		if data
			return data[:ride]
		else
			return false
		end
	end
end
