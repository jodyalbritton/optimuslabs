class Admin::SponsorsController < ApplicationController
  before_action :set_sponsor, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Admin", :admin_index_path
  add_breadcrumb "Sponsors", :admin_settings_path
  layout "layouts/admin"
  before_action :login_required
  before_action :role_required


  def index
  end


   private
    # Use callbacks to share common setup or constraints between actions.
    def set_sponsor
      @sponsor = Sponsor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def setting_params
      params.require(:sponsor).permit(:name, :description, :enabled, :category)
    end
end
