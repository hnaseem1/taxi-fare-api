class Reset < ApplicationRecord
	belongs_to :user
	validates :token, presence: true
	validates :token, uniqueness: true

	# generates a reset token
	def self.generate_reset_token(user)

		user_id = user.id
		token = SecureRandom.hex(10)
		##create a new instance of a reset and save it to the matching user
		reset = Reset.new(user_id: user_id, token: token)
		reset.save
		return token

	end

	# varify if the user has requested the token
	def self.verify_user_requested_reset(token)

		user = Reset.find_by(token)

		if user
			return User.find(user.user_id)

		else
			return false

		end

	end

	# changes password based
	def self.change_password(user, pass, passconf)

		user.password = pass
		user.password_confirmation = passconf
		return user

	end

	# exhausts token so it cant be used later
	def self.exhaust_token(token)

		used_token = Reset.find_by(token)
		exhaust_token = SecureRandom.hex(12)
		used_token.token = exhaust_token

		if used_token.save
			return true
		end

	end

end
