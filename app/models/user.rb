class User < ApplicationRecord
	has_many :posts
	attr_accessor :remember_token
	before_save :downcase_email
	has_secure_password

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, presence: true, length: { maximum: 50 }
	validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: true
	has_secure_password
	validates :password, length: { minimum: 6}

	def downcase_email
		self.email = email.downcase
	end

	#generates a random token
	def self.new_token
		SecureRandom.urlsafe_base64
	end

	#takes a token and encrypts it for database
	def self.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
		BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end		

	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	def forget
		update_attribute(:remember_digest, nil)
	end
end
