class ThoughtsController < ApplicationController

	# GET /thoughts
  	# GET /thoughts.xml
	def index

		@title = "Viewing my thoughts"
		@thoughts = Thought.all

		respond_to do |format|
      			format.html # index.html.erb
			format.xml  { render :xml => @thoughts }
		end
	end

	def filter
		if params[:type] == "timeframe"
			@title = "Thoughts by timeframe"

			@thoughts_soon = Thought.where(:timeframe => "Soon")
			@thoughts_someday = Thought.where(:timeframe => "Someday")
			@thoughts_by_date = Thought.where(:timeframe => "By Date")
			@thoughts_every = Thought.where(:timeframe => "Every")
		end
		if params[:type] == "tag"
			@title = "Thoughts by tag"
			@thoughts = Thought.order("tag DESC")
		end
		if params[:type] == "location"
			@title = "Thoughts by location"
			@thoughts = Thought.where(:note_type => "Location")
		end

	end

  # GET /thoughts/1
  # GET /thoughts/1.xml
  def show
    @thought = Thought.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @thought }
    end
  end

  	# GET /thoughts/new
	# GET /thoughts/new.xml
	def new
  		@title = "Speaking of that..."
		@thought = Thought.new

		respond_to do |format|
		      format.html # new.html.erb
		      format.xml  { render :xml => @thought }
		end
	end

  # GET /thoughts/1/edit
  def edit
    @thought = Thought.find(params[:id])
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

end
