class Admin::CompanyController < ApplicationController
	before_filter :authenticate_user!
  	authorize_actions_for ApplicationAuthorizer
  	add_breadcrumb "Admin", :admin_index_path
  	add_breadcrumb "My Company", :admin_company_path
	layout "layouts/admin"
	add_breadcrumb "Admin", :admin_index_path

	def index
		@employees = User.where(:employee => true)
		@employees_on_the_clock = @employees.where(:clocked_in => true)
	end
end
