class RelationshipsController < ApplicationController
	before_filter :signed_in_user

	def create
    		@user = User.find(params[:relationship][:friend2_id])
		current_user.befriend!(@user)
		@current_relationship = Relationship.last
		@current_relationship.ignite

		FriendMailer.delay.welcome(@user, current_user, @current_relationship.id, root_url)

		respond_to do |format|
			format.html { redirect_to @user }
			format.js
		end
	end

	def acceptance
		relationship = Relationship.find(params[:id])
		relationship.ignite
	end

	def destroy
		@user = Relationship.find(params[:id]).friend2
		if current_user.id == @user.id
			@user = Relationship.find(params[:id]).friend1
			@user_2 = Relationship.find(params[:id]).friend2
			current_user.unfriend!(@user_2)
		else
			current_user.unfriend!(@user)
		end
		respond_to do |format|
			format.html { redirect_to @user }
			format.js
		end
	end

	private

		def signed_in_user
			unless signed_in?
				store_location
	      			redirect_to signin_path, notice: "Please sign in."
			end
		end
end
