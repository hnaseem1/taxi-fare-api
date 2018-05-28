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


	def self.verify_user_exists(user_email)
		return @user = User.find_by(email: user_email) 
	end

	private 
	def unique_token
		unless token == "User Already Used This Token" || !(Reset.find_by(token: token))
			errors.add(:token, "is not unique")
		end
	end




end
