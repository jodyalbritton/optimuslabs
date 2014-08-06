class Admin::VotesController < ApplicationController
   before_filter :load_votable
   layout "layouts/admin"
    
    def upvote
      @user = User.find(current_user)
      @result = "positive"
      @user.likes @votable
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
    end
    end

    def downvote
    @user = User.find(current_user)
    @result = "negative"
    @user.dislikes @votable 
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end

  private 

  def load_votable

    klass = [Video, Photo, Gallery, Comment, Post].detect { |c| params["#{c.name.underscore}_id"] }
    	@votable = klass.find(params["#{klass.name.underscore}_id"])
  
  end
  

  
end
