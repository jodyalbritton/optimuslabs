class User < ActiveRecord::Base
  rolify
  include Authority::UserAbilities
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


 has_many :posts, :foreign_key => 'author_id'
 has_many :notes, :foreign_key => 'created_by_id'
 has_many :messages
 has_many :message_receipts, :as => :receivable
 
 
 def full_name 
    first_name + " " + last_name
 end  

def inbox
	message_receipts.inbox
end

def inbox_and_unread
	message_receipts.inbox_and_unread
end

def sent
	message_receipts.sent
end


end
