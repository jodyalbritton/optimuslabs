class AdminController < ApplicationController
  before_filter :authenticate_user!
  authorize_actions_for ApplicationAuthorizer
	layout "layouts/admin"
	add_breadcrumb "Admin", :admin_index_path

  	
 def index
  	@tasks = Task.where(:completed => false).order('created_at DESC')
    @tickets = Ticket.all
  	@new_task = Task.new

  end

  def add
    @tasks = Task.all
	  @task = Task.create(:item =>params[:task][:item])
	   respond_to do |format|
	    format.html { redirect_to tasks_url }
	    format.js
	   end
  end

  def update
  @task = Task.find(params[:id])
  respond_to do |format|
     if @task.update(task_params)
        format.html { redirect_to ([:admin, @task]), notice: 'Task was successfully updated.' }
        format.js
      else
        format.html { render :edit }
       format.js
      end
  end
end

 private
    # Use callbacks to share common setup or constraints between actions.
  

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:completed, :item)
    end



end
