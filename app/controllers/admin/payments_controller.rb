class Admin::PaymentsController < ApplicationController
  before_filter :authenticate_user!
  authorize_actions_for ApplicationAuthorizer
  add_breadcrumb "Admin", :admin_index_path
  add_breadcrumb "Payments", :admin_payments_path
  before_action :set_payment, only: [:show, :edit, :update, :destroy]
  layout "layouts/admin"

  def index
  	if params[:invoice_id]
       @invoice = Invoice.find(params[:invoice_id])

       @payments = @invoice.payments.all

      else
        @payments = Payment.all
      end
  end

  def show
  end 
  
  def edit
  end


  def new
    if params[:invoice_id]
       @invoice = Invoice.find(params[:invoice_id])

       @payment = @invoice.payments.new

      else
        @payment  = Payment.new
    end
  	
  end

  def create

    if params[:invoice_id]
       @invoice = Invoice.find(params[:invoice_id])

       @payement = @invoice.payments.new(payment_params)

      else
        @payment  = Payment.new(payment_params)
    end

    respond_to do |format|
      if @payment.save
        format.html { redirect_to ([:admin, @payment]), notice: 'Payment was successfully created.' }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end 

  def update

    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to ([:admin, @payment]), notice: 'Payment was successfully created.' }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      if params[:invoice_id]
       @invoice = Invoice.find(params[:invoice_id])

       @payment = @invoice.payments.find(params[:id])

      else
        @payment = Payment.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:amount, :invoice_id)
    end
end
