class Admin::ProjectsController < ApplicationController
  before_filter :authenticate_user!, :load_breadcrumbs
  authorize_actions_for ApplicationAuthorizer
 
  
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  layout :resolve_layout
  # GET /projects
  # GET /projects.json
  def index

      if params[:client_id]
        @client = Client.find(params[:client_id])
        @projects = @client.projects.all
      else
        @projects = Project.all
      end
      session[:return_to] = request.referer
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    add_breadcrumb @project.name
   
    @payable = @project
    @payment_source = @project.client
    session[:return_to] = request.referer
  end

  # GET /projects/new
  def new
    add_breadcrumb "New"
    if params[:client_id]
    @client = Client.find(params[:client_id])
    @project = @client.projects.new
  
   
    else   
    @project = Project.new
    end
    session[:return_to] = request.referer
  end

  # GET /projects/1/edit
  def edit
    add_breadcrumb "Edit"
    session[:return_to] = request.referer
  end

  # POST /projects
  # POST /projects.json
  def create

    if params[:client_id]
    @client = Client.find(params[:client_id])
    @project = @client.projects.new(project_params)
    else   
    @project = Project.new(project_params)
    end

    respond_to do |format|
      if @project.save
        if session[:return_to]
          format.html { redirect_to session.delete(:return_to), notice: 'Project was successfully created.' }
        else
          format.html { redirect_to admin_projects_path, notice: 'Project was successfully created.' }
        end  
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        if session[:return_to]
          format.html { redirect_to session.delete(:return_to), notice: 'Project was successfully updated.' }
        else
          format.html { redirect_to admin_projects_path, notice: 'Project was successfully updated.' }
        end
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      if session[:return_to]
          format.html { redirect_to session.delete(:return_to), notice: 'Project was successfully deleted.' }
        else
          format.html { redirect_to admin_projects_path, notice: 'Project was successfully deleted.' }
        end
      format.json { head :no_content }
    end
  end

  def print
  
  @project = Project.find(params[:project_id])
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def load_breadcrumbs

      if params[:client_id]
      @tickets_client = Client.find(params[:client_id])
      add_breadcrumb "Admin", :admin_index_path
      add_breadcrumb "Clients", :admin_clients_path
      add_breadcrumb  @tickets_client.name, admin_client_path(@tickets_client)
      add_breadcrumb "Projects", :admin_client_projects_path


      else
      add_breadcrumb "Admin", :admin_index_path
      add_breadcrumb "Projects", :admin_projects_path
      end 
  
    end
    def resolve_layout
      case action_name
        when "print"
          "layouts/print"
        else
          "layouts/admin"
      end
    end


    def set_project
      if params[:client_id]
      @client = Client.find(params[:client_id])

      @project = @client.projects.find(params[:id])

      else
      @project = Project.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :client_name, :start_date, :end_date, :description )
    end
end
