class Contact < ActiveRecord::Base
  has_attached_file :avatar, :styles => { :large => "600x600", :medium => "200x200#", :thumb => "100x100#" }, :default_url => ":style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  belongs_to :client
  belongs_to :user 
  has_many :interactions, as: :interactive
  
  before_update :create_full_name

  attr_accessor :total_time
  def create_full_name 
  	if self.full_name == nil 
  		self.full_name = self.first_name + " " + self.last_name
  	end

  end

  def total_time
    self.interactions.sum :time
  end 


  ####  Client Name Auto-complete ####
    def client_name
      self.client.try(:name)
    end

    def client_name=(name)
      self.client = Client.find_by(name: name) if name.present?
    end
end
