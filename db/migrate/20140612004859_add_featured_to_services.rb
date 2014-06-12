class AddFeaturedToServices < ActiveRecord::Migration
  def change
    add_column :services, :featured, :boolean, :default => false
    add_column :services, :sort_value, :integer, :default => 0
  end
end
