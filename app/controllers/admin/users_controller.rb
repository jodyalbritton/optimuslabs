class Admin::UsersController < ApplicationController
  before_filter :authenticate_user!
  authorize_actions_for ApplicationAuthorizer
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  layout "layouts/admin"
  add_breadcrumb "Admin", :admin_index_path
  def index
    @users = User.all
  end

  def show

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

   
    if @user.update_attributes(account_update_params)
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case their password changed
      sign_in @user, :bypass => true
      redirect_to edit_admin_user_path(@user)
    else
      render "edit"
    end
  end

  def destroy
  end

   private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_update_params
      params.require(:user).permit(:email, :username, :first_name, :last_name, :title, :telephone, :mobile_phone,:address, :city, :state, :zip, :password, :password_confirmation, :client_id)
    end
end
