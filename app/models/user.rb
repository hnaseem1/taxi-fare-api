class User < ApplicationRecord
	has_secure_password
	has_many :rides
	has_many :resets
	
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, presence: true, uniqueness: true
end
