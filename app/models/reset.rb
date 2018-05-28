class Reset < ApplicationRecord
	belongs_to :user
	validates :token, presence: true
	validate :generate_unique_token

	private 
	def generate_unique_token
		unless token == "User Already Used This Token" || !(Reset.find_by(token: token))
			errors.add(:token, "is not unique")
		end
	end
end
