class ThoughtsController < ApplicationController

	before_filter :signed_in_user
	before_filter :edit_correct_user, :only => [:edit]
	before_filter :allowed_user, :only => [:show]

	# GET /thoughts
  	# GET /thoughts.xml
	def index
		@title = "Viewing my thoughts"

		# Thought counter
		if current_user.admin?
			@count = Thought.all.count
			@count_incomplete = Thought.where(:complete => [nil, false]).count
		else
			@count = Thought.where(:user_id => current_user.id).count
			@count_incomplete = Thought.where(:user_id => current_user.id, :complete => [nil, false]).count
		end

		# Thoughts
		if current_user.admin?
			if params[:type] == "Incomplete"
				@thoughts = Thought.where(:complete => [nil, false])
			elsif params[:type] == "Completed"
				@thoughts = Thought.where(:complete => true)
			else
				@thoughts = Thought.all
			end
		else
			if params[:type] == "Incomplete"
				@thoughts = Thought.where(:complete => [nil, false], :user_id => current_user.id)
			elsif params[:type] == "Completed"
				@thoughts = Thought.where(:complete => true, :user_id => current_user.id)
			else
				@thoughts = Thought.where(:user_id => current_user.id)
			end
		end

	end

	def filter

		# Thought counter
		if current_user.admin?
			@count = Thought.all.count
			@count_incomplete = Thought.where(:complete => [nil, false]).count
		else
			@count = Thought.where(:user_id => current_user.id).count
			@count_incomplete = Thought.where(:user_id => current_user.id, :complete => [nil, false]).count
		end

		if params[:type] == "timeframe"
			@title = "Thoughts by timeframe"

			if current_user.admin?
				@thoughts_soon = Thought.where(:timeframe => "Soon")
				@thoughts_someday = Thought.where(:timeframe => "Someday")
				@thoughts_by_date = Thought.where(:timeframe => "By Date")
				@thoughts_every = Thought.where(:timeframe => "Every")
			else
				@thoughts_soon = Thought.where(:timeframe => "Soon", :user_id => current_user.id)
				@thoughts_someday = Thought.where(:timeframe => "Someday", :user_id => current_user.id)
				@thoughts_by_date = Thought.where(:timeframe => "By Date", :user_id => current_user.id)
				@thoughts_every = Thought.where(:timeframe => "Every", :user_id => current_user.id)
			end
		elsif params[:type] == "tag"
			@title = "Thoughts by tag"
			if current_user.admin?
				@thoughts = Thought.select("tag").group("tag")
			else
				@thoughts = Thought.where(:user_id => current_user.id).select("tag").group("tag")
			end
		elsif params[:type] == "location"
			@title = "Thoughts by location"

			if current_user.admin?
				@thoughts = Thought.where(:note_location => "1")
			else
				@thoughts = Thought.where(:note_location => "1", :user_id => current_user.id)
			end
		elsif params[:type] == "friends"
			@title = "Thoughts of your friends"
			@thoughts = Thought.from_friends_of(current_user)
		end
	end

	def vote
		@thought = Thought.find(params[:votable])
		if params[:vote] == "true"
			current_user.vote_for(@thought)
		elsif params[:vote] == "false"
			current_user.vote_against(@thought)
		end
	end

	def comment
		@thought = Thought.find(params[:thought_id])
		@comment = Comment.build_from( @thought, current_user.id, params[:comment_area] )
		@comment.save
		@all_comments = @thought.comment_threads.order("comments.created_at DESC")
		@root_comments = @thought.root_comments.order("comments.created_at DESC")
	end

	def quicktag
		@thought = Thought.find(params[:id])
	end

	def completed
		@thought = Thought.find(params[:id])
		@thought.complete = params[:value]

		flash[:success] = "Thought "<< @thought.idea << "completed"

		respond_to do |format|
			if @thought.update_attributes(params[:thought])
				format.html { redirect_to(@thought, :notice => 'Thought was successfully updated.') }
				format.xml  { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml => @thought.errors, :status => :unprocessable_entity }
			end
		end
	end

  	# GET /thoughts/1
  	# GET /thoughts/1.xml
  	def show

		@title = "Viewing a thought"
		@thought = Thought.find(params[:id])
		@all_comments = @thought.comment_threads.order("comments.created_at DESC")
		@root_comments = @thought.root_comments.order("comments.created_at DESC")

		respond_to do |format|
			format.html # show.html.erb
			format.xml  { render :xml => @thought }
		end

  	end

  	# GET /thoughts/new
	# GET /thoughts/new.xml
	def new
  		@title = "Speaking of that..."
		@h1 = "This just popped into my head..."
		@thought = Thought.new

		@thoughts = Thought.where(:user_id => current_user.id)

		@top_tags = @thoughts.each {|thought| print thought.tag }

		if current_user.admin?
			@thoughts_location = Thought.where(:note_location => "1")
		else
			@thoughts_location = Thought.where(:user_id => current_user.id, :note_location => "1")
		end

		respond_to do |format|
		      format.html # new.html.erb
		      format.xml  { render :xml => @thought }
		end
	end

	  # GET /thoughts/1/edit
	  def edit
		@title = "Let's modify that"
		@thought = Thought.find(params[:id])
		@h1 = "Editing my thoughts"
		@thoughts = Thought.all

		if current_user.admin?
			@thoughts_location = Thought.where(:note_location => "1")
		else
			@thoughts_location = Thought.where(:user_id => current_user.id, :note_location => "1")
		end
	  end

	# POST /thoughts
	# POST /thoughts.xml
	def create
		@thought = Thought.new(params[:thought])

		respond_to do |format|
			if @thought.save
	  			format.html { redirect_to(thoughts_path, :notice => 'Thought was successfully created.') }
			        #format.html { redirect_to(@thought, :notice => 'Thought was successfully created.') }
			        format.xml  { render :xml => @thought, :status => :created, :location => @thought }
			else
			        format.html { render :action => "new" }
			        format.xml  { render :xml => @thought.errors, :status => :unprocessable_entity }
			end
		end
	end

  # PUT /thoughts/1
  # PUT /thoughts/1.xml
  def update
    @thought = Thought.find(params[:id])

    respond_to do |format|
      if @thought.update_attributes(params[:thought])
        format.html { redirect_to(@thought, :notice => 'Thought was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @thought.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /thoughts/1
  # DELETE /thoughts/1.xml
  def destroy
    @thought = Thought.find(params[:id])
    @thought.destroy

    respond_to do |format|
      format.html { redirect_to(thoughts_url) }
      format.xml  { head :ok }
    end



  end
	private
		def signed_in_user
      			redirect_to signin_path, notice: "Please sign in." unless signed_in?
    		end
		def edit_correct_user
			user_id = Thought.find(params[:id]).user_id
			@user = User.find(user_id)
			redirect_to root_path, notice: "Cannot view other's thoughts unless friends!" unless current_user?(@user)
		end
		def allowed_user
			user_id = Thought.find(params[:id]).user_id
			@user = User.find(user_id)
			redirect_to root_path, notice: "Cannot view other's thoughts unless friends!" unless (current_user?(@user) ||
													      current_user.admin? ||
													      current_user.friends?(@user))
		end

end
