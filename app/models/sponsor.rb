class Sponsor < ActiveRecord::Base
 extend FriendlyId
 friendly_id :name, use: :slugged
  has_attached_file :avatar, :styles => { :large => "640x480>", :medium => "300x300>", :thumb => "100x100>" }, :default_url => ":style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_attachment_size :avatar, :in => 0.megabytes..4.megabytes

  has_attached_file :banner, :styles => { :leader => "728x90>", :full => "468x60>", :square => "300x300#", :half => "234x60>" }, :default_url => ":style/missing-banner.png"
  validates_attachment_content_type :banner, :content_type => /\Aimage\/.*\Z/
  validates_attachment_size :banner, :in => 0.megabytes..4.megabytes
  validates_presence_of :name 

  is_impressionable counter_cache: true
  has_many :videos
  belongs_to :category
  acts_as_taggable # Alias for acts_as_taggable_on

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
