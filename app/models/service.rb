class Service < ActiveRecord::Base
	has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => ":style/missing.png"
  	validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/
  	has_attached_file :header, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => ":style/missing-header.jpg"
  	validates_attachment_content_type :header, :content_type => /\Aimage\/.*\Z/
	belongs_to :category
	has_many :items, :as => :purchasable
	belongs_to :rate_type


	validates_presence_of :category_id
	validates_presence_of :name 


  extend FriendlyId
  friendly_id :name, use: :slugged
end
