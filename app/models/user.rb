class User < ActiveRecord::Base

  extend FriendlyId
  friendly_id :username, use: :slugged
  rolify
  include Authority::UserAbilities
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :login

  has_attached_file :avatar, :styles => { :large => "600x600", :medium => "200x200#", :thumb => "100x100#" }, :default_url => ":style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
 belongs_to :client
 has_many :posts, :foreign_key => 'author_id'
 has_many :notes, :foreign_key => 'created_by_id'
 has_many :messages
 has_many :message_receipts, :as => :receivable
 has_one :contact
 has_many :timesheets
 has_many :interactions, as: :interactive
 
 validates :username,
  :uniqueness => {
    :case_sensitive => false}
 

def time_worked_this_week
    time_worked_this_week = 0
    sheets = self.timesheets.where(:created_at => Date.today.beginning_of_week..Date.tomorrow)
    sheets.each do |sheet|
     time_worked_this_week = sheet.time_worked + time_worked_this_week
    end
    time_worked_this_week
end

def total_time
    self.interactions.sum :time
end 

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
