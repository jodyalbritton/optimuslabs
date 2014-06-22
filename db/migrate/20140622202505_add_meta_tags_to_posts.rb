class AddMetaTagsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :meta_description, :string
    add_column :posts, :meta_keywords, :string
  end
end
