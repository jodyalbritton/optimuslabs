class Category < ActiveRecord::Base
	has_many :posts
	has_many :services
	has_many :products
	has_many :videos
end
