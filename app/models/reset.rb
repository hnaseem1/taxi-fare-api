class Reset < ApplicationRecord
	belongs_to :user
	validates :token, presence: true
	validate :unique_token

	def self.generate_reset_token(user)
		@user = user
		user_id = @user.id
		token = SecureRandom.hex(10)
		##create a new instance of a reset and save it to the matching user
		reset = Reset.new(user_id: user_id, token: token)
		reset.save
		return token 
	end 


	def self.verify_user_requested_reset(token)
		user = Reset.find_by(token: token)
		if user
			return User.find(user.user_id)
		else
			return false 
		end
	end
	def self.change_password(user, pass, passconf)
		user.password = pass
		user.password_confirmation = passconf
		return user
	end

	def self.exhaust_token(token)
		used_token = Reset.find_by(token: token)
		exhaust_token = SecureRandom.hex(12)
		used_token.token = exhaust_token
		if used_token.save
			return true
		end
	end
	private 
	def unique_token
		unless token == "User Already Used This Token" || !(Reset.find_by(token: token))
			errors.add(:token, "is not unique")
		end
	end
end
