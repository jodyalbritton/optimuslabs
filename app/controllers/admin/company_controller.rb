class Admin::CompanyController < ApplicationController
	before_filter :authenticate_user!
  	authorize_actions_for ApplicationAuthorizer
	layout "layouts/admin"
	add_breadcrumb "Admin", :admin_index_path

	def index
		@users = User.all
	end
end
