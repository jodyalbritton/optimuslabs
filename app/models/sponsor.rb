class Sponsor < ActiveRecord::Base
 extend FriendlyId
  has_attached_file :avatar, :styles => { :large => "600x403#", :medium => "300x300#", :thumb => "100x100>" }, :default_url => "/assets/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  friendly_id :name, use: :slugged

  belongs_to :category

end
