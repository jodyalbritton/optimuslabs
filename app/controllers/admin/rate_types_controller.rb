class Admin::RateTypesController < ApplicationController
  before_filter :authenticate_user!
  authorize_actions_for ApplicationAuthorizer
  layout "layouts/admin"
  add_breadcrumb "Admin", :admin_index_path
  add_breadcrumb "Posts", :admin_rate_types_path

  before_action :set_rate_type, only: [:show, :edit, :update, :destroy]

  # GET /rate_types
  # GET /rate_types.json
  def index
    @rate_types = RateType.all
  end

  # GET /rate_types/1
  # GET /rate_types/1.json
  def show
  end

  # GET /rate_types/new
  def new
    @rate_type = RateType.new
  end

  # GET /rate_types/1/edit
  def edit
  end

  # POST /rate_types
  # POST /rate_types.json
  def create
    @rate_type = RateType.new(rate_type_params)

    respond_to do |format|
      if @rate_type.save
        format.html { redirect_to admin_rate_type_path(@rate_type), notice: 'Rate type was successfully created.' }
        format.json { render :show, status: :created, location: @rate_type }
      else
        format.html { render :new }
        format.json { render json: @rate_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rate_types/1
  # PATCH/PUT /rate_types/1.json
  def update
    respond_to do |format|
      if @rate_type.update(rate_type_params)
        format.html { redirect_to admin_rate_type_path(@rate_type), notice: 'Rate type was successfully updated.' }
        format.json { render :show, status: :ok, location: @rate_type }
      else
        format.html { render :edit }
        format.json { render json: @rate_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rate_types/1
  # DELETE /rate_types/1.json
  def destroy
    @rate_type.destroy
    respond_to do |format|
      format.html { redirect_to rate_types_url, notice: 'Rate type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rate_type
      @rate_type = RateType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rate_type_params
      params.require(:rate_type).permit(:name, :unit)
    end
end
