class Admin::InvoiceStatusesController < ApplicationController
  before_filter :authenticate_user!
  authorize_actions_for ApplicationAuthorizer
  layout "layouts/admin"
  add_breadcrumb "Admin", :admin_index_path
  add_breadcrumb "Invoice Statuses", :admin_invoice_statuses_path

  before_action :set_invoice_status, only: [:show, :edit, :update, :destroy]

  # GET /invoice_statuss
  # GET /invoice_statuss.json
  def index
    @invoice_statuses = InvoiceStatus.order('position ASC')
  end

  # GET /invoice_statuss/1
  # GET /invoice_statuss/1.json
  def show
  end

  # GET /invoice_statuss/new
  def new
    @invoice_status = InvoiceStatus.new
  end

  # GET /invoice_statuss/1/edit
  def edit
  end

  # POST /invoice_statuss
  # POST /invoice_statuss.json
  def create
    @invoice_status = InvoiceStatus.new(invoice_status_params)

    respond_to do |format|
      if @invoice_status.save
        format.html { redirect_to admin_invoice_status_path(@invoice_status), notice: 'Severity type was successfully created.' }
        format.json { render :show, status: :created, location: @invoice_status }
      else
        format.html { render :new }
        format.json { render json: @invoice_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoice_statuss/1
  # PATCH/PUT /invoice_statuss/1.json
  def update
    respond_to do |format|
      if @invoice_status.update(invoice_status_params)
        format.html { redirect_to admin_invoice_status_path(@invoice_status), notice: 'Severity type was successfully updated.' }
        format.json { render :show, status: :ok, location: @invoice_status }
      else
        format.html { render :edit }
        format.json { render json: @invoice_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoice_statuss/1
  # DELETE /invoice_statuss/1.json
  def destroy
    @invoice_status.destroy
    respond_to do |format|
      format.html { redirect_to invoice_statuses_url, notice: 'Severity type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice_status
      @invoice_status = InvoiceStatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_status_params
      params.require(:invoice_status).permit(:state, :description, :position)
    end
end
