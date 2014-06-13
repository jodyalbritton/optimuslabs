class ApplicationController < ActionController::Base


  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :layout_by_resource
  before_action :configure_permitted_parameters, if: :devise_controller?
 
  def access_denied
    flash[:error] = t('the_role.access_denied')
    redirect_to(:back)
  end
  
  def layout_by_resource 
  	if devise_controller?
  		"appView"

    else 

       
    "application"

    end



  end
  


protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :username, :first_name, :last_name, :tel, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:email, :username, :first_name, :last_name, :tel, :password, :password_confirmation, :current_password)
    end
  end




end
