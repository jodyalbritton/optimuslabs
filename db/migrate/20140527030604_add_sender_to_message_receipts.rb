class AddSenderToMessageReceipts < ActiveRecord::Migration
  def change
   add_reference :message_receipts, :sender, polymorphic: true
  end
end
