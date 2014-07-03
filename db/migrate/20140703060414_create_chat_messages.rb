class CreateChatMessages < ActiveRecord::Migration
  def change
    create_table :chat_messages do |t|
      t.references :user, index: true
      t.string :message
      t.string :socket_id

      t.timestamps
    end
  end
end
