class Photo < ActiveRecord::Base
  belongs_to :gallery
  belongs_to :category
  acts_as_taggable # Alias for acts_as_taggable_on
  has_attached_file :file, :styles => {:large=> "700x567>", :medium => "400x267>", :thumb => "90x60>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/
end
