require 'pusher'


class Admin::ChatMessagesController < ApplicationController


  def index
    @chat_message = ChatMessage.new
  end

  def create
    
    
    Pusher['chat'].trigger('new_message', {
      name: params[:chat_message][:name],
      message:  params[:chat_message][:message],
      socket_id: params[:chat_message][:socket_id]
    })
    
    

    
  end


   private
    # Use callbacks to share common setup or constraints between actions.
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def chat_message_params
      params.require(:chat_message).permit(:name, :message, :socket_id)
    end
end