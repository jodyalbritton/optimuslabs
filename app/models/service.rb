class Service < ActiveRecord::Base
 extend FriendlyId
 monetize :price_cents
 monetize :cost_cents
 
  friendly_id :name, use: :slugged
  acts_as_list
	has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => ":style/missing.png"
  	crop_attached_file :logo
  has_attached_file :header, :styles => {:large => "800x400>", :medium => "300x300>", :thumb => "100x100>" }, :default_url => ":style/missing-header.jpg"
  	
	belongs_to :category
	has_many :items, :as => :purchasable
	belongs_to :rate_type
	has_many :attachments, as: :attachable 

	validates_presence_of :category_id
	validates_presence_of :name
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/ 
  validates_attachment_content_type :header, :content_type => /\Aimage\/.*\Z/


  def category_name
    self.category.try(:name)
  end

  def category_name=(name)
    self.category = Category.find_or_create_by(name: name) if name.present?
  end

end
