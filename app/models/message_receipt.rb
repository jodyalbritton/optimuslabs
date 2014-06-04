class MessageReceipt < ActiveRecord::Base
  belongs_to :message
  belongs_to :receivable, :polymorphic => true
  belongs_to :sender, :polymorphic => true



  scope :inbox, -> { where(mailbox_type: "Inbox") }
  scope :inbox_and_unread, -> { inbox.where(read: false) }

  scope :sent, -> { where(mailbox_type: "Sent") }
end
