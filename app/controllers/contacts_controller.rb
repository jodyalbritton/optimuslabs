
class ContactsController < ApplicationController
  def new
  	@contact = Contact.new
  end

  def create
  	@contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to (contacts_thanks_path), notice: 'You are now subscribed' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def thanks
  end


  def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:full_name, :first_name, :last_name, :email, :phone, :notes, :url, :avatar, :client_id, :avatar)
    end


end
