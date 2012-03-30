class PagesController < ApplicationController

	def home
		@title = "Home"
		@title2 = "Easily find your thoughts"
		@title3 = "See what's nearby you"
		if !current_user.nil?
			@users = User.where('id <> ? ', current_user.id)

			if current_user.admin?
				@thoughts_nearby = Thought.where(:note_location => "1")
				@thoughts_recent = Thought.order("created_at DESC").group("tag").limit(6)
			else
				@thoughts_nearby = Thought.where(:user_id => current_user, :note_location => "1")
				@thoughts_recent = Thought.where(:user_id => current_user).order("created_at DESC").group("tag").limit(6)
			end
		end
	end

	def tags
		@title = "Viewing tags"
		if current_user.admin?
			@thoughts = Thought.where(:tag => params[:tag])
		else
			@thoughts = Thought.where(:user_id => current_user.id, :tag => params[:tag])
		end
	end

	def dates
		@title = "Viewing dates"
		if current_user.admin?
			@thoughts = Thought.where(:timeframe_date => params[:date])
		else
			@thoughts = Thought.where(:user_id => current_user.id, :timeframe_date => params[:date])
		end
	end
end
