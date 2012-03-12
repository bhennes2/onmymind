class Thought < ActiveRecord::Base

	belongs_to :user

	def self.search(search,type)
  		if type == "Idea"
			where('idea LIKE ?', "%#{search}%")
		elsif type == "Tag"
			where('tag LIKE ?', "%#{search}%")
		elsif type == "Date"
			where('timeframe_date LIKE ?', "%#{search}%")
		else
			scoped
		end
	end
end
