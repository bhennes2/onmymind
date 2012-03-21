class User < ActiveRecord::Base

	has_many :thoughts, dependent: :destroy
	has_many :relationships, foreign_key: "friend1_id", dependent: :destroy
	has_many :friends, through: :relationships, source: :friend2

	has_many :reverse_relationships, foreign_key: "friend2_id", class_name: "Relationship", dependent: :destroy
	has_many :reverse_friends, through: :reverse_relationships, source: :friend1

	#Allows users to vote on thoughts
	acts_as_voter

	attr_accessible :username, :email, :password, :password_confirmation
	has_secure_password
	before_save :create_remember_token

	validates(:username, presence: true)
	validates(:email, presence: true, uniqueness: true)

	validates :password, length: { minimum: 6 }



	def friends?(other_user)
		if relationships.find_by_friend2_id(other_user.id).nil?
			reverse_relationships.find_by_friend1_id(other_user.id)
		else
			relationships.find_by_friend2_id(other_user.id)
		end
	end

	def befriend!(other_user)
		relationships.create!(friend2_id: other_user.id)
	end

	def unfriend!(other_user)
		if self.id == other_user.id
			target = Relationship.where(:friend2_id => other_user.id)[0]
			Relationship.find(target.id).destroy
		else
			relationships.find_by_friend2_id(other_user.id).destroy
		end
	end


	private
		def create_remember_token
    			self.remember_token = SecureRandom.urlsafe_base64
 		end


end
