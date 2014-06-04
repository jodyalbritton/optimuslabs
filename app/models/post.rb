class Post < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  attr_accessor :search 
  
  belongs_to :author, :class_name => 'User'
  belongs_to :category
  acts_as_taggable # Alias for acts_as_taggable_on
  paginates_per 10

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  # Try building a slug based on the following fields in
  # increasing order of specificity.
  def slug_candidates
    [
      :title
     
    ]
  end

end
