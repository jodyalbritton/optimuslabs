class AddSlugToVideos < ActiveRecord::Migration
  def change
  	add_column :videos, :views, :integer
  	add_column :videos, :position, :integer
 	add_column :videos, :published_at, :time
 	add_column :videos, :yt_updated_at, :time
    add_column :videos, :slug, :string
    add_index :videos, :slug, unique: true
  end

end
