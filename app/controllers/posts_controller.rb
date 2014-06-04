class PostsController < ApplicationController
  add_breadcrumb "Home", :root_url
  add_breadcrumb "Blog", :posts_path
  def index
    

    if params[:search] 
  	@posts =  Post.search(params[:search]).records.page(params[:page])
    else

    @posts = Post.order(:published_at).page(params[:page])
  	end 
    @tags = ActsAsTaggableOn::Tag.all
    @categories = Category.all
  	@posts_by_month = Post.all.group_by { |post| post.published_at.strftime("%B %Y") }
  end

  def show
    add_breadcrumb "Post", :post_path
	  @post = Post.friendly.find(params[:id])
    @tags = ActsAsTaggableOn::Tag.all
     @categories = Category.all
    @posts_by_month = Post.all.group_by { |post| post.published_at.strftime("%B") }
  end



def tagged
  if params[:tag].present? 
    @categories = Category.all
  	@posts = Post.tagged_with(params[:tag])
    @posts_by_month = Post.all.group_by { |post| post.published_at.strftime("%B") }
    @tags = ActsAsTaggableOn::Tag.all
   
  else 
  	@tags = ActsAsTaggableOn::Tag.all
    @posts = Post.all
    @posts_by_month = Post.all.group_by { |post| post.published_at.strftime("%B") }
     @categories = Category.all
  end  
end

def categorized
  if params[:category].present? 
    @categories = Category.all
    @posts = Post.where('category' => params[:category])
    @posts_by_month = Post.all.group_by { |post| post.published_at.strftime("%B") }
    @tags = ActsAsTaggableOn::Tag.all
   
  else 
    @tags = ActsAsTaggableOn::Tag.all
    @posts = Post.all
    @posts_by_month = Post.all.group_by { |post| post.published_at.strftime("%B") }
    @categories = Category.all
  end  
end

end
