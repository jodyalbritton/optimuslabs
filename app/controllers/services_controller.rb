class ServicesController < ApplicationController
  add_breadcrumb "Home", :root_url
  add_breadcrumb "Services", :services_url
  

  def index
  	@services = Service.all
  end

  def show
  	 @service = Service.friendly.find(params[:id])
  	 add_breadcrumb @service.name, :post_path
  end
end
