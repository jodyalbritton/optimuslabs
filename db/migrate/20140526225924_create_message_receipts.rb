class CreateMessageReceipts < ActiveRecord::Migration
  def change
    create_table :message_receipts do |t|
      t.integer :receivable_id
      t.string  :receivable_type
      t.references :message, index: true
      t.boolean :read
      t.boolean :trashed
      t.boolean :deleted
      t.string :mailbox_type

      t.timestamps
    end
  end
end
