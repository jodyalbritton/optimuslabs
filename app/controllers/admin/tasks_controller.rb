class Admin::TasksController < ApplicationController
  before_filter :authenticate_user!
  authorize_actions_for ApplicationAuthorizer
  add_breadcrumb "Admin", :admin_index_path
  add_breadcrumb "Tasks", :admin_tasks_path
  layout "layouts/admin"

  def new  
     respond_to do |format|
        format.js
      end
  end

  def index
  	@tasks = Task.where(:completed => false).order('position ASC')
  	@new_task = Task.new

  end

  def create
    if params[:client_id]
      @client = Client.find(params[:client_id])
      @tasks = @client.tasks.where(:completed => false).order('created_at DESC')
      @task = @client.tasks.create(:item =>params[:task][:item])
    else 
      @tasks = Task.where(:completed => false).order('created_at DESC')
      @task = Task.create(:item =>params[:task][:item])
     end
	 
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

def sort
 params[:task].each_with_index do |id, index|
        task = Task.find(id)
        task.position = index
        task.save
    end
    render nothing: true
end

 private
    # Use callbacks to share common setup or constraints between actions.
  

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:completed, :item, :client, :position)
    end

end
