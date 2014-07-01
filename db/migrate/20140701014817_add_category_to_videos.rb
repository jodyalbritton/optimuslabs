class AddCategoryToVideos < ActiveRecord::Migration
  def change
    add_reference :videos, :category, index: true
    add_column :videos, :featured, :boolean, :default => true
    add_column :videos, :listed, :boolean, :default => true
    add_column :videos, :yt_tags, :string

  end
end
