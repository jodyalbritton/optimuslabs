class Admin::TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Admin", :admin_index_path
  add_breadcrumb "Tickets", :admin_categories_path
  layout "layouts/admin"
  before_action :login_required
  before_action :role_required
 

  def index
    @tickets = Ticket.all
  end

  def show 
  end 

  def new
    @ticket = Ticket.new
  end

  def edit
  end

  def create
     @ticket = Ticket.new(ticket_params)

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
      params.require(:ticket).permit(:subject, :client_id, :description, :severity, :status, :location)
    end
end
