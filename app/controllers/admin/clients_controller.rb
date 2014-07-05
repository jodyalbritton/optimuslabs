class Admin::ClientsController < ApplicationController
  before_filter :authenticate_user!
  authorize_actions_for ApplicationAuthorizer
  add_breadcrumb "Admin", :admin_index_path
  add_breadcrumb "Clients", :admin_clients_path
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  layout "layouts/admin"

  # GET /clients
  # GET /clients.json
  def index
    if params[:term]
      @clients = Client.order(:name).where("name like ?", "%#{params[:term]}%")
      render json: @clients.map(&:name)
    else
      @clients = Client.all
    end


  end

  # GET /clients/1
  # GET /clients/1.json
  def show
     add_breadcrumb @client.name
     @new_task = Task.new
     @unpaid_invoices = (@client.invoices.opened + @client.invoices.in_progress + @client.invoices.quoted).first(10)
  end

  # GET /clients/new
  def new
    add_breadcrumb "New"
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
    session[:return_to] = request.referer
    add_breadcrumb "Edit"
  end

  # POST /clients
  # POST /clients.json
  def create
    session[:return_to] = request.referer
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        format.html { redirect_to session.delete(:return_to), notice: 'Client was successfully created.' }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html {  redirect_to session.delete(:return_to), notice: 'Client was successfully updated.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to admin_clients_url, notice: 'Client was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:name, :email, :phone, :description, :url, :avatar, :address, :city, :state, :zip, :featured)
    end
end
