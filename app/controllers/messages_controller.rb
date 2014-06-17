class MessagesController < ApplicationController
 
	def new
      @message = Message.new
	end

	def create
     

     @message = Message.new(message_params)
  	
   

    respond_to do |format|
      if @message.save
        format.html { redirect_to page_path('home'), notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
   
  	end
  end

	private
    # Use callbacks to share common setup or constraints between actions.
  

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:full_name, :email, :body, :subject, :phone, :source, :recipient)
    end

end