class ChangeDateFormatInVideos < ActiveRecord::Migration
  def change
  	 change_column :videos, :published_at, :datetime
  	 change_column :videos, :yt_updated_at, :datetime
  end
end
