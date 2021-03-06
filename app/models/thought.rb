class Thought < ActiveRecord::Base

	belongs_to :user

	# Allow thoughts to be voted on
	acts_as_voteable

	# Allow thoughts to be commented on
	acts_as_commentable

	def self.search(search)

		results = Array.new

		ideas = self.where('idea LIKE ?', "%#{search}%")
		tags = self.where('tag LIKE ?', "%#{search}%")
		dates = self.where('timeframe_date LIKE ?', "%#{search}%")

		if ideas != []
			ideas.each do |idea|
				results << idea
			end
		end
		if tags != []
			tags.each do |tag|
				results << tag
			end
		end
		if dates != []
			dates.each do |date|
				results << date
			end
		end
		return results
	end

	default_scope :order => 'thoughts.created_at DESC'

	#Returns thoughts from the users who are friends of the given user.
	scope :from_friends_of, lambda { |user| friends_of(user) }

	private

		# Returns an SQL condition for friends of the given user.
		# We include the user's own id as well.
		def self.friends_of(user)
			friend_ids = user.friend_ids.concat(user.reverse_friend_ids)
			where("user_id IN (:friend_ids)", { friend_ids: friend_ids })
		end
end
