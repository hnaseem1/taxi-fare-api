class UserMailer < ApplicationMailer
	default from: 'taxi.fare.api@gmail.com'

	def welcome_email(user)
		@user = user
		@company = "taxi-fare-api"
		@url = "app-path.com"
		mail(to: @user.email, subject: "welcome to taxi-fare-api!")
	end

	def ride_info_email(user, ride)
		@user = user
		@ride = ride

		mail(to: @user.email. subject: "You took a ride to #{@ride.end_address}!")
	end
end
