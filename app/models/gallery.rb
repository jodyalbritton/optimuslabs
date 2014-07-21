class Gallery < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged
	searchkick
	has_many :photos
	belongs_to :category
	acts_as_taggable # Alias for acts_as_taggable_on
end
