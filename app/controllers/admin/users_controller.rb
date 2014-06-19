class Admin::UsersController < ApplicationController
  before_filter :authenticate_user!
  authorize_actions_for ApplicationAuthorizer
  add_breadcrumb "Admin", :admin_index_path
  add_breadcrumb "Users", :admin_users_path
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  layout "layouts/admin"
  
  def index
      if params[:client_id]
        @client = Client.find(params[:client_id])
        @users = @client.users.order('created_at ASC')
      else 
        @users = User.all
      end
  end

  def show

    @new_interaction = @user.interactions.new
    @interactions = @user.interactions.order('created_at DESC')

  end

  def new
    
  end

  def edit

  end

  def create

  end

  def update
   
    # For Rails 3
    # account_update_params = params[:user]

    # required for settings form to submit when password is left blank
    if account_update_params[:password].blank?
      account_update_params.delete("password")
      account_update_params.delete("password_confirmation")
    end

      successfully_updated = if needs_password?(@user, account_update_params)
                             @user.update(user_params)
                           else
                             @user.update_without_password(account_update_params)
                           end

     respond_to do |format|
      if successfully_updated
        format.html { redirect_to edit_admin_user_path(@user), notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

   private
    # Use callbacks to share common setup or constraints between actions.
    def set_user

      @user = User.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_update_params
      params.require(:user).permit(:email, :username, :first_name, :last_name, :title, :telephone, :mobile_phone,:address, :city, :state, :zip, :password, :password_confirmation, :client_id, :employee, :clocked_in)
    end

    def needs_password?(user, params)
    params[:password].present?
  end
end
