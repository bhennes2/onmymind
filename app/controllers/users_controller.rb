class UsersController < ApplicationController

	before_filter :signed_in_user, :only => [:index, :show, :edit, :update, :friends]
	before_filter :allowed_user, :only => [:show]

	def index
		@title = "Find some friends"
		@users = User.where('id <> ? ', current_user.id)
	end

	def new
		@title = "New User Sign up"
		@user = User.new
	end
	def show
		@title = "Showing user profile"
		@user = User.find(params[:id])

		if current_user.admin?
			@users = User.all
		end
  	end

	def friends
		@title = "These are your friends"
		@user = User.find(params[:id])
		@users = @user.friends + @user.reverse_friends
		render 'show_friends'
	end

	def edit

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
		def allowed_user
			@user = User.find(params[:id])
			redirect_to(root_path) unless ( current_user?(@user) || current_user.friends?(@user) )
		end
end
