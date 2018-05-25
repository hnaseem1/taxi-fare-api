class Reset < ApplicationRecord
	belongs_to :user
	validates :token, presence: true
	validate :generate_unique_token

	private 
	def generate_unique_token
		all_tokens = Reset.all
		all_hashes = Array.new

		all_tokens.each do |obj|
			all_hashes.push(obj.token)
		end

		unless token == "User Already Used This Token" || all_hashes.each{|_hash| token != _hash}
			errors.add(:token, "token is not unique")
		end
	end
end
