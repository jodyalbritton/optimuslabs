class Admin::TimesheetsController < ApplicationController
  before_filter :authenticate_user!
  authorize_actions_for ApplicationAuthorizer
  add_breadcrumb "Admin", :admin_index_path
  add_breadcrumb "Timesheet", :admin_timesheets_path
  before_action :set_timesheet, only: [:show, :edit, :update, :destroy]
  layout "layouts/admin"

	

	def index 
		if params[:user_id]
	    	@user = User.friendly.find(params[:user_id])
	    	@timesheets = @user.timesheets.order('created_at DESC')
			if @user.clocked_in == true
				@timesheet = @user.timesheets.last 
			else 
				@timesheet = @user.timesheets.new 
			end 
		else 

			@timesheets = Timesheet.order('created_at DESC')
			@user = User.friendly.find(current_user)
				if @user.clocked_in == true
					@timesheet = @user.timesheets.last 
				else 
				@timesheet = @user.timesheets.new 
		end		end 
	end
	def edit

	end

	def new  
		@timesheet = Timesheet.new
    	respond_to do |format|
    		format.html
        	format.js
      	end
  	end

  	def create

	    
	      if params[:timesheet][:source] == "TIMECLOCK"
	      	@user = User.find(params[:timesheet][:user_id])
	      	@user.clocked_in = true
	      	@user.save
	      	@timesheets = Timesheet.order('created_at DESC')
	      	@timesheet =  @user.timesheets.create(:user_id =>params[:timesheet][:userid], :clocked_in => Time.now)

	     

	  	  else
	  	  	 @timesheets = Timesheet.order('created_at DESC')
	         @timesheet = Timesheet.create(timesheet_params)
	      end
  
	      
		respond_to do |format|
		    format.html { redirect_to admin_timesheets_url }
		    format.js
	   end
  	end

  	def update

	       @timesheets = Timesheet.order('created_at DESC')
	       if params[:timesheet][:source] == "TIMECLOCK"
	      		@user = User.find(params[:timesheet][:user_id])
	      		@user.clocked_in = false
	      		@user.save
	      		@timesheet.update(:clocked_out => Time.now)
	      	else 
	       		@timesheet.update(timesheet_params)

	     	end 
	      	
	      	@timesheet = Timesheet.new
			respond_to do |format|
		    	format.html { redirect_to admin_timesheets_url }
		    	format.js
	    
	   	end
  	end


 private
    # Use callbacks to share common setup or constraints between actions.
    def set_timesheet
      @timesheet = Timesheet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def timesheet_params
      params.require(:timesheet).permit(:clocked_in, :clocked_out, :user_id, :source)
    end
end
