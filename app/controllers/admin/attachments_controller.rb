class Admin::AttachmentsController < ApplicationController
  before_filter :authenticate_user!, :load_attachable
  authorize_actions_for ApplicationAuthorizer
  before_action :set_attachment, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Admin", :admin_index_path
  add_breadcrumb "Attachments", :admin_attachments_path
  layout "layouts/admin"
	def new 
	   @attachment = @attachable.attachments.new
    end

    def create
    	@attachment = @attachable.attachments.create(attachment_params)
    	redirect_to ([:admin, @attachable])
    end 

    private
    # Use callbacks to share common setup or constraints between actions.
     def load_attachable
  		if params[:product_id]
    		@attachable = Product.friendly.find(params[:product_id])
  		elsif params[:service_id]
    		@attachable = Service.friendly.find(params[:service_id])
  		elsif params[:ticket_id]
   			@attachable = Ticket.find(params[:ticket_id])
  		end
	end
    def set_attachment
      @attachment = Attachment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attachment_params
      params.require(:attachment).permit(:file)
    end
end
