class Admin::PaymentsController < ApplicationController
  before_filter :authenticate_user!
  authorize_actions_for ApplicationAuthorizer
  add_breadcrumb "Admin", :admin_index_path
  add_breadcrumb "Payments", :admin_payments_path
  before_action :set_payment, only: [:show, :edit, :update, :destroy]
  layout "layouts/admin"

  def index
  	@payments = Payment.all
  end

  def show
  end 
  

  def new
  	@payment = Payment.new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      if params[:client_id]
      @client = Client.find(params[:client_id])

      @payement = @client.payments.find(params[:id])

      else
        @payment = Payment.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:amount, :invoice_id)
    end
end
