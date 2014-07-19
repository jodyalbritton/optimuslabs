class Gallery < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged
	searchkick
	has_many :photos
	belongs_to :category
end
