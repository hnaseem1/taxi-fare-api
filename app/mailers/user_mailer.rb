class UserMailer < ApplicationMailer
	default from: 'taxi.fare.api@gmail.com'

	# method to be used when user creates an account
	def welcome_email(user)
		@user = user
		@company = "ScoopFare!"
		@url = "http://www.scoopfare.com"
		mail(to: @user.email, subject: "Welcome to ScoopFare!")

	end

	# email for informing the user if they took a ride
	def ride_info_email(user, ride)
		@user = user
		@ride = ride

		mail(to: @user.email, subject: "You took a ride to #{@ride.end_address}!")
	end

	# password reset email
	def password_reset_email(user, reset_hash)
		@time = (Time.now).strftime("%a %b %e %T %Y")
		@user = user
		@reset = reset_hash
		mail(to: @user.email, subject: "#{@user.first_name}, here is your password reset token")
	end

	# email informing the password has been reset
	def password_reset_success_email(user)
		@time = (Time.now).strftime("%a %b %e %T %Y")
		@user = user
		mail(to:@user.email, subject: "#{@user.first_name}, you just successfully reset your password!")
	end

	def ride_pool(emails_array, current_user)
		emails_array.delete(current_user.email)
		@user = current_user
		@count = emails_array.count
		@people = emails_array
		if @count > 1
			mail(to:current_user.email, subject: "You have a ride match with #{@count} people")
		else 
			mail(to:current_user.email, subject: "You have a ride match with a person")
		end
	end

	def ride_pool_previous(emails_array, current_user, start_location, end_location)
		@start = start_location
		@end = end_location
		@emails = emails_array.delete(current_user.email)
		byebug
		@emails.each do |email|
			@user = User.find_by(email: email)
			mail(to: email, subject: "You have a ride match!")
		end
	end
end
