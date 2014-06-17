class Admin::SeverityTypesController < ApplicationController
  before_filter :authenticate_user!
  authorize_actions_for ApplicationAuthorizer
  layout "layouts/admin"
  add_breadcrumb "Admin", :admin_index_path
  add_breadcrumb "Severity Types", :admin_severity_types_path

  before_action :set_severity_type, only: [:show, :edit, :update, :destroy]

  # GET /severity_types
  # GET /severity_types.json
  def index
    @severity_types = SeverityType.all
  end

  # GET /severity_types/1
  # GET /severity_types/1.json
  def show
  end

  # GET /severity_types/new
  def new
    @severity_type = SeverityType.new
  end

  # GET /severity_types/1/edit
  def edit
  end

  # POST /severity_types
  # POST /severity_types.json
  def create
    @severity_type = SeverityType.new(severity_type_params)

    respond_to do |format|
      if @severity_type.save
        format.html { redirect_to admin_severity_type_path(@severity_type), notice: 'Severity type was successfully created.' }
        format.json { render :show, status: :created, location: @severity_type }
      else
        format.html { render :new }
        format.json { render json: @severity_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /severity_types/1
  # PATCH/PUT /severity_types/1.json
  def update
    respond_to do |format|
      if @severity_type.update(severity_type_params)
        format.html { redirect_to admin_severity_type_path(@severity_type), notice: 'Severity type was successfully updated.' }
        format.json { render :show, status: :ok, location: @severity_type }
      else
        format.html { render :edit }
        format.json { render json: @severity_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /severity_types/1
  # DELETE /severity_types/1.json
  def destroy
    @severity_type.destroy
    respond_to do |format|
      format.html { redirect_to severity_types_url, notice: 'Severity type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_severity_type
      @severity_type = SeverityType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def severity_type_params
      params.require(:severity_type).permit(:name, :description, :position)
    end
end
