class Admin::SponsorsController < ApplicationController
  before_filter :authenticate_user!
  authorize_actions_for ApplicationAuthorizer
  before_action :set_sponsor, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Admin", :admin_index_path
  add_breadcrumb "Sponsors", :admin_sponsors_path
  layout "layouts/admin"



  def index
    @sponsors = Sponsor.all
  end

  def show
  end

  # GET /sponsors/new
  def new
    @sponsor = Sponsor.new
  end

  # GET /sponsors/1/edit
  def edit
  end

  # POST /sponsors
  # POST /sponsors.json
  def create
    @sponsor = Sponsor.new(sponsor_params)

    respond_to do |format|
      if @sponsor.save
        format.html { redirect_to ([:admin, @sponsor]), notice: 'Sponsor was successfully created.' }
        format.json { render :show, status: :created, location: @sponsor }
      else
        format.html { render :new }
        format.json { render json: @sponsor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sponsors/1
  # PATCH/PUT /sponsors/1.json
  def update
    respond_to do |format|
      if @sponsor.update(sponsor_params)
        format.html { redirect_to ([:admin, @sponsor]), notice: 'Sponsor was successfully updated.' }
        format.json { render :show, status: :ok, location: @sponsor }
      else
        format.html { render :edit }
        format.json { render json: @sponsor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sponsors/1
  # DELETE /sponsors/1.json
  def destroy
    @sponsor.destroy
    respond_to do |format|
      format.html { redirect_to admin_sponsors_url, notice: 'Sponsor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


   private
    # Use callbacks to share common setup or constraints between actions.
    def set_sponsor
      @sponsor = Sponsor.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sponsor_params
      params.require(:sponsor).permit(:name, :description, :enabled, :category_id, :avatar, :address, :city, :state, :zip, :url, :video_url, :phone, :email)
    end
end
