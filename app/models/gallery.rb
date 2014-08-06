class Gallery < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: [:slugged, :finders]
	searchkick
	has_many :photos
	belongs_to :category
	acts_as_taggable # Alias for acts_as_taggable_on
	acts_as_votable
	acts_as_commentable
end
