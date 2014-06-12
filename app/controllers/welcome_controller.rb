class WelcomeController < ApplicationController
  add_breadcrumb "Home", :root_url
  def index

  	@recent_posts = Post.where(:draft => false ).order("published_at DESC").first(3)
  	@client_hightlight = Client.where(:featured => true).first(4)
    @featured_services = Service.where(:featured => true).order(:sort_value).first(4)
    @contact = Contact.new
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
