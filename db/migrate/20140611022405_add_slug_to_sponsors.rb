class AddSlugToSponsors < ActiveRecord::Migration
  def change
    add_column :sponsors, :slug, :string
    add_index :sponsors, :slug, unique: true
  end
end
