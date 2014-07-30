class Admin::GalleriesController < ApplicationController
	before_filter :authenticate_user!
  authorize_actions_for ApplicationAuthorizer
  before_action :set_gallery, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Admin", :admin_index_path
  add_breadcrumb "Galleries", :admin_galleries_path
  layout "layouts/admin"
  impressionist :actions=>[:show]
  # GET /galleries
  # GET /galleries.json
  def index
    if params[:term]
      @galleries = Gallery.order(:name).where("name like ?", "%#{params[:term]}%")
      render json: @galleries.map(&:name)
    else 
      @galleries = Gallery.all
    end
   
  end

  # GET /galleries/1
  # GET /galleries/1.json
  def show
  end

  # GET /galleries/new
  def new
    add_breadcrumb "New"
    @gallery = Gallery.new
  end

  # GET /galleries/1/edit
  def edit
     add_breadcrumb "Edit"
  end

  # POST /galleries
  # POST /galleries.json
  def create
    @gallery = Gallery.new(gallery_params)

    respond_to do |format|
      if @gallery.save
        format.html { redirect_to ([:admin, @gallery]), notice: 'Gallery was successfully created.' }
        format.json { render :show, status: :created, location: @gallery }
      else
        format.html { render :new }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /galleries/1
  # PATCH/PUT /galleries/1.json
  def update
    respond_to do |format|
      if @gallery.update(gallery_params)
        format.html { redirect_to ([:admin, @gallery]), notice: 'Gallery was successfully updated.' }
        format.json { render :show, status: :ok, location: @gallery }
      else
        format.html { render :edit }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /galleries/1
  # DELETE /galleries/1.json
  def destroy
    @gallery.destroy
    respond_to do |format|
      format.html { redirect_to galleries_url, notice: 'Gallery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def tags 
    @tags = ActsAsTaggableOn::Tag.where("tags.name LIKE ?", "%#{params[:q]}%") 
    respond_to do |format|
     format.json { render :json => @tags.collect{|t| {:id => t.name, :name => t.name }}}
    end
  end 


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gallery
      @gallery = Gallery.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gallery_params
      params.require(:gallery).permit(:name, :description, :tag_list)
    end
end
