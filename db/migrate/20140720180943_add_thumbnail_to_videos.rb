class AddThumbnailToVideos < ActiveRecord::Migration
  def change
  	add_attachment :videos, :thumbnail
  end
end
