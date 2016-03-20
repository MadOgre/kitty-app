class User < ActiveRecord::Base
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :username, presence: true, uniqueness: true
	validates :email, presence: true, uniqueness: true, format: {with: VALID_EMAIL_REGEX}
	has_secure_password
	
end