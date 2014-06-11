class Admin::InteractionsController < ApplicationController
	layout "layouts/admin"
  before_action :login_required
  before_action :role_required
  def new  
     respond_to do |format|
        format.js
      end
  end

  def index
  	@interactions = Interaction.order('created_at DESC')
  	@new_interaction = Interaction.new

  end

  def create
    if params[:contact_id]
      @contact = Contact.find(params[:contact_id])
      @interactions = @contact.interactions.order('created_at DESC')
      @interaction = @contact.interactions.create(:event =>params[:interaction][:event],:content=> params[:interaction][:content])
    else 
      @interactions = Interaction.order('created_at DESC')
      @interaction = Interaction.create(:event =>params[:interaction][:event],:content=> params[:interaction][:content])
     end
	 
	   respond_to do |format|
	    format.html { redirect_to admin_interactions_url }
	    format.js
	   end
  end

  def update
  @interaction = Interaction.find(params[:id])
  respond_to do |format|
     if @interaction.update(interaction_params)
        format.html { redirect_to ([:admin, @interaction]), notice: 'Interaction was successfully updated.' }
        format.js
      else
        format.html { render :edit }
       format.js
      end
  end
end

 private
    # Use callbacks to share common setup or constraints between actions.
  

    # Never trust parameters from the scary internet, only allow the white list through.
    def interaction_params
      params.require(:interaction).permit(:event, :content)
    end


end
