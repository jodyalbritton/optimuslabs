class User < ActiveRecord::Base
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/
  extend FriendlyId
  friendly_id :username, use: :slugged
  rolify
  include Authority::UserAbilities
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  attr_accessor :login

  has_attached_file :avatar, :styles => { :large => "600x600", :medium => "200x200#", :thumb => "100x100#" }, :default_url => ":style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
 belongs_to :client
 has_many :posts, :foreign_key => 'author_id'
 has_many :notes, :foreign_key => 'created_by_id'
 has_many :messages
 has_many :message_receipts, :as => :receivable
 has_one :contact
 has_many :payments, as: :source
 has_many :timesheets
 has_many :interactions, as: :interactive
 has_many :clients
 validates :username,

  :uniqueness => { :case_sensitive => false}
 


  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update
  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          name: auth.extra.raw_info.name,
          #username: auth.info.nickname || auth.uid,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
        user.skip_confirmation!
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end
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
