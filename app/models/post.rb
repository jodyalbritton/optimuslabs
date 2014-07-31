class Post < ActiveRecord::Base
  searchkick
  is_impressionable counter_cache: true
  attr_accessor :search
  has_attached_file :photo, :styles => { :large => "750x450#", :medium => "360x244#", :thumb => "100x100#" }, :default_url => ":style/missing.png"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  validates_attachment_size :photo, :in => 0.megabytes..4.megabytes
  crop_attached_file :photo, :aspect => "16:9"
  belongs_to :author, :class_name => 'User'
  belongs_to :category
  acts_as_taggable # Alias for acts_as_taggable_on
  acts_as_votable
  acts_as_commentable
  paginates_per 10

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders]



  validates_presence_of :title 
  # Try building a slug based on the following fields in
  # increasing order of specificity.
  def slug_candidates
    [
      :title
     
    ]
  end

def get_views 
   self.impressionist_count
end 

def fetch_likes
  self.cached_votes_up - self.cached_votes_down
end 

def category_name
  self.category.try(:name)
end

def category_name=(name)
  self.category = Category.find_or_create_by(name: name) if name.present?
end
end
