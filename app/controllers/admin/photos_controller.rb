class Admin::PhotosController < ApplicationController
  before_filter :authenticate_user!
  authorize_actions_for ApplicationAuthorizer
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Admin", :admin_index_path
  add_breadcrumb "Photos", :admin_photos_path
  layout "layouts/admin"

  def new
  	if params[:gallery_id]
  		@gallery = Gallery.friendly.find(params[:gallery_id])

    	@photo = @gallery.photos.new
    else 
  		@photo = Photo.new
  	end
    session[:return_to] = request.referer
  end

  def create
    if params[:gallery_id]
      @gallery = Gallery.friendly.find(params[:gallery_id])
      @photo = @gallery.photos.create(photo_params)
    else 
      @photo = Photo.create(photo_params)
    end
    respond_to do |format|
      if @photo.save
        format.html { redirect_to admin_gallery_path(@gallery), notice: 'Photo was successfully created.' }
        format.json { render :show, status: :created, location: @Photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end 
  
  def destroy
  @gallery = Gallery.find(@photo.gallery)
  @photo.destroy
  respond_to do |format|
    format.html { redirect_to admin_gallery_path(@gallery), notice: 'Photo was successfully destroyed.' }
    format.json { head :no_content }
  end
  
  end
    private

    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:file, :gallery_id, :category_id, :gallery, :category)
    end

end
