require 'pusher'


class Admin::ChatMessagesController < ApplicationController


  def index
    @chat_message = ChatMessage.new
  end

  def create
    @chat_message = ChatMessage.create(chat_message_params)
    
    Pusher['chat'].trigger('new_message', {
      user_id: @chat_message.user.id,
      first_name: @chat_message.user.first_name,
      avatar:   view_context.image_path(@chat_message.user.avatar(:thumb)),
      message:  @chat_message.message,
      socket_id: @chat_message.socket_id
    })
    
    

    
  end


   private
    # Use callbacks to share common setup or constraints between actions.
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def chat_message_params
      params.require(:chat_message).permit(:user_id, :message, :socket_id, :channel, :first_name, :last_name, :avatar)
    end
end