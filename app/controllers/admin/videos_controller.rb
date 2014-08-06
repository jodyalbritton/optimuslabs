class Admin::VideosController < ApplicationController
  before_filter :authenticate_user!
  authorize_actions_for ApplicationAuthorizer

  before_action :set_video, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Admin", :admin_index_path
  add_breadcrumb "Videos", :admin_videos_path
  layout "layouts/admin"
  def index
    @videos = Video.order('created_at DESC')
  end

  def new
    @video = Video.new
  end

  def show
    impressionist(@video)
    @comments = @video.comment_threads.order(:cached_votes_up).reverse
    @new_comment = Comment.build_from(@video, current_user, "")
    @commentable = @video
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      flash[:success] = 'Video added!'
      redirect_to admin_videos_url
    else
      render 'new'
    end
  end
  
  def update
   
    if @video.update(video_params)
      flash[:success] = 'Video updated!'
      redirect_to admin_videos_url
    else
      render 'new'
    end
  end

  def destroy
     @video.destroy
    respond_to do |format|
      format.html { redirect_to admin_videos_url, notice: 'Video was successfully destroyed.' }
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
    def set_video
      @video = Video.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:link, :views, :description, :likes, :tag_list, :dislikes, :author, :title, :duration,:category, :category_name, :sponsor_name, :sponsored, :sponsor_id, :yt_updated_at, :published_at)
    end
end