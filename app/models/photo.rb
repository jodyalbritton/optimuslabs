class Photo < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
  is_impressionable counter_cache: true
  belongs_to :gallery
  belongs_to :category
  acts_as_taggable # Alias for acts_as_taggable_on
  acts_as_votable
  acts_as_commentable
  has_attached_file :file, :styles => {:large=> "700x567>", :medium => "400x267>", :thumb => "90x60>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/
  validates_attachment_size :file, :in => 0.megabytes..4.megabytes
end
