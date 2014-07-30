 class Admin::CommentsController < ApplicationController
  
   layout "layouts/admin"

      def create
        comment = Comment.new(comment_params)
        commentable = params[:comment][:commentable_type].constantize.find(params[:comment][:commentable_id])
        comment.commentable = commentable
        comment.user = current_user
        respond_to do |format|
      if comment.save
        format.html { redirect_to [:admin, commentable], notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: [commentable] }
      else
        format.html { render :new }
        format.json { render json: [commentable].errors, status: :unprocessable_entity }
      end
    end
      end
      def destroy
        @comment = Comment.find(params[:id])

        @commentable = @comment.commentable


        if @comment.destroy
          @comments_refreshed = @commentable.comment_threads.order(:cached_votes_up).reverse
        else
          render :js => "alert('error deleting comment');"
        end
      end


    private 
    
    def comment_params
      params.require(:comment).permit!
    end

    

    


 end