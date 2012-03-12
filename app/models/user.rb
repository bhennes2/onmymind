class User < ActiveRecord::Base

	has_many :thoughts

	attr_accessible :username, :email, :password, :password_confirmation
	has_secure_password
	before_save :create_remember_token

	validates(:username, presence: true)
	validates(:email, presence: true, uniqueness: true)

	validates :password, length: { minimum: 6 }



	private
		def create_remember_token
    			self.remember_token = SecureRandom.urlsafe_base64
 		end


end
