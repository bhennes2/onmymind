class PagesController < ApplicationController

	def home
		@title = "Home"
	end

	def tags
		@title = "Viewing tags"
		@thoughts = Thought.where(:user_id => current_user.id, :tag => params[:tag])
	end

	def dates
		@title = "Viewing dates"
		@thoughts = Thought.where(:user_id => current_user.id, :timeframe_date => params[:date])
	end
end
