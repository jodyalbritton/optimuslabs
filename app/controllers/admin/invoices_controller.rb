class Admin::InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]
  layout "layouts/admin"
  before_action :login_required
  before_action :role_required
  # GET /invoices
  # GET /invoices.json
  def index
      if params[:client_id]
        @client = Client.find(params[:client_id])
        @invoices = @client.invoices.all
      else
        @invoices = Invoice.all
      end
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
  end

  # GET /invoices/new
  def new

    if params[:client_id]
    @client = Client.find(params[:client_id])
    @invoice = @client.invoices.new
  
   
    else   
    @invoice = Invoice.new
  

    end
  end

  # GET /invoices/1/edit
  def edit
  end

  # POST /invoices
  # POST /invoices.json
  def create
    if params[:client_id]
    @client = Client.find(params[:client_id])
    @invoice = @client.invoices.new(invoice_params)
    else   
    @invoice = Invoice.new(invoice_params)
    end

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to ([:admin, @invoice]), notice: 'Invoice was successfully created.' }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoices/1
  # PATCH/PUT /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to ([:admin, @invoice]), notice: 'Invoice was successfully updated.' }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to admin_invoices_url, notice: 'Invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      if params[:client_id]
      @client = Client.find(params[:client_id])

      @invoice = @client.invoices.find(params[:id])

      else
        @invoice = Invoice.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_params
      params.require(:invoice).permit(:subject, :client_id, :started_on, :completed_on, :total, :notes, :attention, :inv_number, :balance, :paid,  items_attributes: [:id, :subject, :target_identifier, :purchasable_type, :purchasable_id, :quantity, :_destroy] )
    end
end
