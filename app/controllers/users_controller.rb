class UsersController < ApplicationController

	before_filter :signed_in_user
	before_filter :correct_user

	def new
		@title = "New User Sign up"
		@user = User.new
	end
	def show
		@title = "Showing user profile"
		@user = User.find(params[:id])
  	end
	def create
    		@user = User.new(params[:user])
    		if @user.save
			sign_in @user
			flash[:success] = "Success! Welcome to OMM!"
			redirect_to root_url
		else
			render 'new'
		end
	end

	private

		def signed_in_user
      			redirect_to signin_path, notice: "Please sign in." unless signed_in?
    		end
		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_path) unless current_user?(@user)
		end
end
