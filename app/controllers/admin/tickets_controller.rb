class Admin::TicketsController < ApplicationController
  before_filter :authenticate_user!
  authorize_actions_for ApplicationAuthorizer
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Admin", :admin_index_path
  add_breadcrumb "Tickets", :admin_tickets_path
  layout "layouts/admin"

 

  def index
    if params[:client_id]
    @client = Client.find(params[:client_id])
    @tickets = @client.tickets.all
    elsif params[:closed]
    @tickets = Ticket.where(:status => "Closed")

    else 
    @tickets = Ticket.where.not(:status => "Closed")


    end
  end

  def show 
    @new_interaction = @ticket.interactions.new
    @interactions = @ticket.interactions.order('created_at DESC')
  end 

  def new
    if params[:client_id]
      @client = Client.find(params[:client_id])
      @ticket = @client.tickets.new
    else

      @ticket = Ticket.new
    end
  end

  def edit
  end

  def create
    if params[:client_id]
     @client = Client.find(params[:client_id])
     @ticket = @client.tickets.new(ticket_params)
    else
     @ticket = Ticket.new(ticket_params)
    end

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to admin_ticket_path(@ticket), notice: 'Ticket was successfully created.' }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
     respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to ([:admin, @ticket]), notice: 'Ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
     @ticket.destroy
    respond_to do |format|
      format.html { redirect_to admin_tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



 private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:subject, :client_id, :description, :severity, :ticket_status_id, :location, :resolution)
    end
end
