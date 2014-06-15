class User < ActiveRecord::Base
  rolify
  include Authority::UserAbilities
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :login
 belongs_to :client
 has_many :posts, :foreign_key => 'author_id'
 has_many :notes, :foreign_key => 'created_by_id'
 has_many :messages
 has_many :message_receipts, :as => :receivable
 
 validates :username,
  :uniqueness => { :case_sensitive => false}
 
 def self.find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions).first
      end
end

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

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end


end
