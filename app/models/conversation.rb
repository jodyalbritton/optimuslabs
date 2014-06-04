class Conversation < ActiveRecord::Base


  has_many :messages, :dependent => :destroy
  has_many :message_receipts, :through => :messages
end
