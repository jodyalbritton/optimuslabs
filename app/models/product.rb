class Product < ActiveRecord::Base
  extend FriendlyId
  acts_as_list
  friendly_id :name, use: :slugged
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => ":style/missing.png"
  	validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  has_many :attachments, as: :attachable 
  belongs_to :category
end
