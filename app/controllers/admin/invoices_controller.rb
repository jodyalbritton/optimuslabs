class Admin::InvoicesController < ApplicationController
  before_filter :authenticate_user!, :load_breadcrumbs
  authorize_actions_for ApplicationAuthorizer
 
  
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]
  layout :resolve_layout
  # GET /invoices
  # GET /invoices.json
  def index

      if params[:client_id]
        @client = Client.find(params[:client_id])
        @invoices = @client.invoices.all
      else
        @invoices = Invoice.all
      end
      session[:return_to] = request.referer
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
    add_breadcrumb @invoice.subject
    @payment = @invoice.payments.new 
    @payable = @invoice
    @payment_source = @invoice.client
    session[:return_to] = request.referer
  end

  # GET /invoices/new
  def new
    add_breadcrumb "New"
    if params[:client_id]
    @client = Client.find(params[:client_id])
    @invoice = @client.invoices.new
  
   
    else   
    @invoice = Invoice.new
    end
  end

  # GET /invoices/1/edit
  def edit
    add_breadcrumb "Edit"
    session[:return_to] = request.referer
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
        if session[:return_to]
          format.html { redirect_to session.delete(:return_to), notice: 'Invoice was successfully created.' }
        else
          format.html { redirect_to admin_invoices_path, notice: 'Invoice was successfully created.' }
        end  
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
        if session[:return_to]
          format.html { redirect_to session.delete(:return_to), notice: 'Invoice was successfully updated.' }
        else
          format.html { redirect_to admin_invoices_path, notice: 'Invoice was successfully updated.' }
        end
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
      if session[:return_to]
          format.html { redirect_to session.delete(:return_to), notice: 'Invoice was successfully deleted.' }
        else
          format.html { redirect_to admin_invoices_path, notice: 'Invoice was successfully deleted.' }
        end
      format.json { head :no_content }
    end
  end

  def print
  
  @invoice = Invoice.find(params[:invoice_id])
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def load_breadcrumbs

      if params[:client_id]
      @tickets_client = Client.find(params[:client_id])
      add_breadcrumb "Admin", :admin_index_path
      add_breadcrumb "Clients", :admin_clients_path
      add_breadcrumb  @tickets_client.name, admin_client_path(@tickets_client)
      add_breadcrumb "Invoices", :admin_client_invoices_path


      else
      add_breadcrumb "Admin", :admin_index_path
      add_breadcrumb "Invoices", :admin_invoices_path
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
      params.require(:invoice).permit(:subject, :client_name,:status, :started_on, :aasm_state,:completed_on, :total, :notes, :attention, :inv_number, :balance, :paid,  items_attributes: [:id, :subject, :cost, :price, :description, :target_identifier, :purchasable_type, :purchasable_id, :quantity, :_destroy], notes_attributes: [:id, :body] )
    end
end
