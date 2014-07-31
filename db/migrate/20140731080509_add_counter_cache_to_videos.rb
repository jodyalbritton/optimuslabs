class AddCounterCacheToVideos < ActiveRecord::Migration
  def change
  	 add_column :videos, :impressions_count, :integer, default: 0
  	 add_column :photos, :impressions_count, :integer, default: 0
  	 add_column :galleries, :impressions_count, :integer, default: 0
  	 add_column :posts, :impressions_count, :integer, default: 0
  	 add_column :sponsors, :impressions_count, :integer, default: 0
  end
end
