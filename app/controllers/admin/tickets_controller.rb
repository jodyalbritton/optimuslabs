class Admin::TicketsController < ApplicationController
  before_filter :authenticate_user!,  :load_breadcrumbs
  authorize_actions_for ApplicationAuthorizer


  
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  layout :resolve_layout
  # GET /tickets
  # GET /tickets.json
  def index
      if params[:client_id]
        @client = Client.find(params[:client_id])
        @tickets = @client.tickets.all
      elsif params[:closed]
        @tickets = Ticket.closed
      else
        @tickets = Ticket.where("aasm_state != ?", :closed)


      end
      session[:return_to] = request.referer
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
    add_breadcrumb @ticket.subject
    @new_interaction = @ticket.interactions.new
    @interactions = @ticket.interactions.order('created_at DESC')
    session[:return_to] = request.referer
  end

  # GET /tickets/new
  def new

    add_breadcrumb "New"
    if params[:client_id]
    @client = Client.find(params[:client_id])
    @ticket = @client.tickets.new
  
   
    else   
    @ticket = Ticket.new
    end
  end

  # GET /tickets/1/edit
  def edit
    add_breadcrumb "Edit"
    session[:return_to] = request.referer
  end

  # POST /tickets
  # POST /tickets.json
  def create

    if params[:client_id]
    @client = Client.find(params[:client_id])
    @ticket = @client.tickets.new(ticket_params)
    else   
    @ticket = Ticket.new(ticket_params)
    end

    respond_to do |format|
      if @ticket.save
        if session[:return_to]
          format.html { redirect_to session.delete(:return_to), notice: 'Ticket was successfully created.' }
        else
          format.html { redirect_to admin_tickets_path, notice: 'Ticket was successfully created.' }
        end  
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        if session[:return_to]
          format.html { redirect_to session.delete(:return_to), notice: 'Ticket was successfully updated.' }
        else
          format.html { redirect_to admin_tickets_path, notice: 'Ticket was successfully updated.' }
        end
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      if session[:return_to]
          format.html { redirect_to session.delete(:return_to), notice: 'Ticket was successfully deleted.' }
        else
          format.html { redirect_to admin_tickets_path, notice: 'Ticket was successfully deleted.' }
        end
      format.json { head :no_content }
    end
  end

  def print
  
  @ticket = Ticket.find(params[:ticket_id])
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def load_breadcrumbs

      if params[:client_id]
      @tickets_client = Client.find(params[:client_id])
      add_breadcrumb "Admin", :admin_index_path
      add_breadcrumb "Clients", :admin_clients_path
      add_breadcrumb  @tickets_client.name, admin_client_path(@tickets_client)
      add_breadcrumb "Tickets", :admin_client_tickets_path


      else
      add_breadcrumb "Admin", :admin_index_path
      add_breadcrumb "Tickets", :admin_tickets_path
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


    def set_ticket
      if params[:client_id]
      @client = Client.find(params[:client_id])

      @ticket = @client.tickets.find(params[:id])

      else
      @ticket = Ticket.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
       params.require(:ticket).permit(:subject, :client_name, :description, :severity, :ticket_status_id, :location, :resolution, :status, :severity_type_id)
    end
end
