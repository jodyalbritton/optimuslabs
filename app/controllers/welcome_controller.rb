class WelcomeController < ApplicationController
  add_breadcrumb "Home", :root_url
  def index

  	@recent_posts = Post.where(:draft => false ).order("published_at DESC").first(3)
  	@client_hightlight = Client.first(4)
  end

  def about
    add_breadcrumb "About Us"
  end

  def contact
    
     add_breadcrumb "Contact Us"
  	 @message = Message.new
  end

  def message_params
      params.require(:message).permit(:full_name, :email, :body, :subject, :phone)
  end
end
