class Admin::TicketStatusesController < ApplicationController
  before_filter :authenticate_user!
  authorize_actions_for ApplicationAuthorizer
  layout "layouts/admin"
  add_breadcrumb "Admin", :admin_index_path
  add_breadcrumb "Ticket Statuses", :admin_ticket_statuses_path

  before_action :set_ticket_status, only: [:show, :edit, :update, :destroy]

  # GET /ticket_statuss
  # GET /ticket_statuss.json
  def index
    @ticket_statuses = TicketStatus.order('position ASC')
  end

  # GET /ticket_statuss/1
  # GET /ticket_statuss/1.json
  def show
  end

  # GET /ticket_statuss/new
  def new
    @ticket_status = TicketStatus.new
  end

  # GET /ticket_statuss/1/edit
  def edit
  end

  # POST /ticket_statuss
  # POST /ticket_statuss.json
  def create
    @ticket_status = TicketStatus.new(ticket_status_params)

    respond_to do |format|
      if @ticket_status.save
        format.html { redirect_to admin_ticket_status_path(@ticket_status), notice: 'Severity type was successfully created.' }
        format.json { render :show, status: :created, location: @ticket_status }
      else
        format.html { render :new }
        format.json { render json: @ticket_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ticket_statuss/1
  # PATCH/PUT /ticket_statuss/1.json
  def update
    respond_to do |format|
      if @ticket_status.update(ticket_status_params)
        format.html { redirect_to admin_ticket_status_path(@ticket_status), notice: 'Severity type was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket_status }
      else
        format.html { render :edit }
        format.json { render json: @ticket_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ticket_statuss/1
  # DELETE /ticket_statuss/1.json
  def destroy
    @ticket_status.destroy
    respond_to do |format|
      format.html { redirect_to ticket_statuses_url, notice: 'Severity type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket_status
      @ticket_status = TicketStatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_status_params
      params.require(:ticket_status).permit(:state, :description, :position)
    end
end
