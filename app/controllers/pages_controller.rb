class PagesController < ApplicationController

	def home
		@title = "Home"
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
