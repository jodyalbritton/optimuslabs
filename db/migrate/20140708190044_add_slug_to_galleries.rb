class AddSlugToGalleries < ActiveRecord::Migration
  def change
    add_column :galleries, :slug, :string
    add_index :galleries, :slug, unique: true
    add_column :photos, :slug, :string
    add_index :photos, :slug, unique: true
  end
end
