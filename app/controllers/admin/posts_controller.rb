class Admin::PostsController < ApplicationController
  before_filter :authenticate_user!
  authorize_actions_for ApplicationAuthorizer
  layout "layouts/admin"

  add_breadcrumb "Admin", :admin_index_path
  add_breadcrumb "Posts", :admin_posts_path


  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.where(:draft => false).order("published_at DESC")
    @drafts = Post.where(:draft => true).order("published_at DESC")
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  
  end

  # GET /posts/new
  def new
    add_breadcrumb "New"
    @user = current_user
    @post = @user.posts.new
  end

  # GET /posts/1/edit
  def edit
     add_breadcrumb "Edit"
  end

  # POST /posts
  # POST /posts.json
  def create
    @user = current_user  
    @post = @user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to admin_post_path(@post), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to admin_post_path(@post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to admin_posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end





  private
    



    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    

    def post_params
      params.require(:post).permit(:title, :body, :published_at, :author_id, :draft, :excerpt, :author, :tag_list, :category_id, :photo)
    end
end
