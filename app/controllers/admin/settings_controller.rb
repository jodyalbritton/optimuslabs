class Admin::SettingsController < ApplicationController
  before_filter :authenticate_user!
  authorize_actions_for ApplicationAuthorizer
  before_action :set_setting, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Admin", :admin_index_path
  add_breadcrumb "Settings", :admin_settings_path
  layout "layouts/admin"


def index
    # to get all items for render list
    @settings = Setting.unscoped.order(:position)
  end

  def edit
    @setting = Setting.unscoped.find(params[:id])
    @setting[:value] = YAML.load(@setting[:value])
    
  end
    def new
    add_breadcrumb "New"
    @setting = Setting.new
  end
   def create
    @setting = Setting.new(setting_params)
    @setting.var= params[:setting][:var]
    @setting.value = params[:setting][:value]

    respond_to do |format|
      if @setting.save
        format.html { redirect_to ([:admin, @setting]), notice: 'Setting was successfully created.' }
        format.json { render :show, status: :created, location: @setting }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update

    @setting.var = params[:setting][:var]
    @setting.value = params[:setting][:value]

    respond_to do |format|
      if @setting.update(setting_params)
        format.html { redirect_to admin_setting_path, notice: 'Setting was successfully updated.' }
        format.json { render :show, status: :ok, location: @setting }
      else
        format.html { render :edit }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end


   def update_all
      params["setting"].keys.each do |id|
        @setting = Setting.unscoped.find(id.to_i)
        @setting.var = params["setting"][id]["var"]
        @setting.value = params["setting"][id]["value"]
        @setting.update_attributes(setting_params)

      end 
        redirect_to(admin_settings_url)

  end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_setting
      @setting = Setting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def setting_params
      params.require(:setting).permit(:var, :value)
    end
end
