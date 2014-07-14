class PostsController < ApplicationController
  add_breadcrumb "Home", :root_url
  add_breadcrumb "Blog", :blog_path
  def index
    

    if params[:search] 
  	@posts =  Post.search(params[:search])
    else

    @posts = Post.order(:published_at).page(params[:page])
  	end 
    @tags = ActsAsTaggableOn::Tag.all
    @categories = Category.all
  	@posts_by_year = Post.all.group_by { |post| post.published_at.beginning_of_year }
  end

  def show
    @post = Post.friendly.find(params[:id])
    add_breadcrumb @post.title, :post_path
	
    @tags = ActsAsTaggableOn::Tag.all
     @categories = Category.all
    @posts_by_year = Post.all.group_by { |post| post.published_at.beginning_of_year }
  end



def tagged
  if params[:tag].present? 
    @categories = Category.all
  	@posts = Post.tagged_with(params[:tag]).order(:published_at).reverse
    @posts_by_year = Post.all.group_by { |post| post.published_at.beginning_of_year }
   
  else 
  	@tags = ActsAsTaggableOn::Tag.all
    @posts = Post.order(:published_at).reverse
    @posts_by_year = Post.all.group_by { |post| post.published_at.beginning_of_year }
     @categories = Category.all
  end  
end

def categorized
  if params[:category].present? 
    @categories = Category.all
    @posts = Post.where('category' => params[:category]).order(:published_at).reverse
   @posts_by_year = Post.all.group_by { |post| post.published_at.beginning_of_year }
    @tags = ActsAsTaggableOn::Tag.all
   
  else 
    @tags = ActsAsTaggableOn::Tag.all
    @posts = Post.all
   @posts_by_year = Post.all.group_by { |post| post.published_at.beginning_of_year }
    @categories = Category.all
  end  
end

end
