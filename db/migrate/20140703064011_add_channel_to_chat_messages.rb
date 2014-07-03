class AddChannelToChatMessages < ActiveRecord::Migration
  def change
    add_column :chat_messages, :channel, :string
  end
end
