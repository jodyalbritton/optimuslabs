class Admin::TasksController < ApplicationController
  layout "layouts/admin"
  before_action :login_required
  before_action :role_required
  def new  
     respond_to do |format|
        format.js
      end
  end

  def index
  	@tasks = Task.where(:completed => false).order('created_at DESC')
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

 private
    # Use callbacks to share common setup or constraints between actions.
  

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:completed, :item, :client)
    end

end
