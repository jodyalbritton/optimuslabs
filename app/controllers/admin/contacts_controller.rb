class Admin::ContactsController < ApplicationController
  before_filter :authenticate_user!, :load_breadcrumbs
  authorize_actions_for ApplicationAuthorizer
  
  
 

  

  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  layout :resolve_layout
  # GET /contacts
  # GET /contacts.json
  def index

      if params[:client_id]
        @client = Client.find(params[:client_id])
        @contacts = @client.contacts.all
      elsif params[:term]
      @contacts = Contact.order(:email).where("email like ?", "%#{params[:term]}%")
      render json: @contacts.map(&:email)

      else 
        @contacts = Contact.all
      end
      session[:return_to] = request.referer
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    add_breadcrumb @contact.full_name
    @new_interaction = @contact.interactions.new
    @interactions = @contact.interactions.order('created_at DESC')
    session[:return_to] = request.referer
  end

  # GET /contacts/new
  def new

   
    add_breadcrumb "New"
    if params[:client_id]
    @client = Client.find(params[:client_id])
    @contact = @client.contacts.new
  
   
    else   
    @contact = Contact.new
    end
    session[:return_to] = request.referer
  end

  # GET /contacts/1/edit
  def edit
    add_breadcrumb ("Editing:"+"  "+@contact.full_name)
    session[:return_to] = request.referer
  end

  # POST /contacts
  # POST /contacts.json
  def create

    if params[:client_id]
    @client = Client.find(params[:client_id])
    @contact = @client.contacts.new(contact_params)
    else   
    @contact = Contact.new(contact_params)
    end

    respond_to do |format|
      if @contact.save
        if session[:return_to]
          format.html { redirect_to session.delete(:return_to), notice: 'Contact was successfully created.' }
        else
          format.html { redirect_to admin_contacts_path, notice: 'Contact was successfully created.' }
        end  
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        if session[:return_to]
          format.html { redirect_to session.delete(:return_to), notice: 'Contact was successfully updated.' }
        else
          format.html { redirect_to admin_contacts_path, notice: 'Contact was successfully updated.' }
        end
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      if session[:return_to]
          format.html { redirect_to session.delete(:return_to), notice: 'Contact was successfully deleted.' }
        else
          format.html { redirect_to admin_contacts_path, notice: 'Contact was successfully deleted.' }
        end
      format.json { head :no_content }
    end
  end

  



  # Use callbacks to share common setup or constraints between actions.
  private
    def load_breadcrumbs

      if params[:client_id]
      @contacts_client = Client.find(params[:client_id])
      add_breadcrumb "Admin", :admin_index_path
      add_breadcrumb "Clients", :admin_clients_path
      add_breadcrumb  @contacts_client.name, admin_client_path(@contacts_client)
      add_breadcrumb "Contacts", :admin_client_contacts_path


      else
      add_breadcrumb "Admin", :admin_index_path
      add_breadcrumb "Contacts", :admin_contacts_path
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


    def set_contact
      if params[:client_id]
      @client = Client.find(params[:client_id])

      @contact = @client.contacts.find(params[:id])

      else
      @contact = Contact.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:full_name, :first_name, :recipient_email, :last_name, :client_name, :email, :phone, :notes, :url, :avatar, :client_id, :avatar)
    end
end
