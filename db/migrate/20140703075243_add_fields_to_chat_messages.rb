class AddFieldsToChatMessages < ActiveRecord::Migration
  def change
    add_column :chat_messages, :avatar, :string
    add_column :chat_messages, :username, :string
    add_column :chat_messages, :first_name, :string
    add_column :chat_messages, :last_name, :string
  end
end
