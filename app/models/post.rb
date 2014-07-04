class Post < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  attr_accessor :search
  has_attached_file :photo, :styles => { :large => "750x450#", :medium => "360x244#", :thumb => "100x100#" }, :default_url => ":style/missing.png"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  crop_attached_file :photo, :aspect => "16:9"
  belongs_to :author, :class_name => 'User'
  belongs_to :category
  acts_as_taggable # Alias for acts_as_taggable_on
  paginates_per 10

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged



  validates_presence_of :title 
  # Try building a slug based on the following fields in
  # increasing order of specificity.
  def slug_candidates
    [
      :title
     
    ]
  end


def category_name
  self.category.try(:name)
end

def category_name=(name)
  self.category = Category.find_or_create_by(name: name) if name.present?
end
end
