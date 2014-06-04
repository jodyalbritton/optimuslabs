class AddSiteToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :site_id, :integer
    add_index :posts, :site_id
  end
end
