class Admin::CompanyController < ApplicationController
	before_filter :authenticate_user!
  	authorize_actions_for ApplicationAuthorizer
  	add_breadcrumb "Admin", :admin_index_path
  	add_breadcrumb "My Company", :admin_company_path
	layout "layouts/admin"
	add_breadcrumb "Admin", :admin_index_path

	def index
		@user = User.find(current_user)
		@chat_message = ChatMessage.new
		@employees = User.where(:employee => true)
		@employees_on_the_clock = @employees.where(:clocked_in => true)
		@message_history = ChatMessage.where(:channel => "COMPANY_CHAT").last(100)
	end
end
