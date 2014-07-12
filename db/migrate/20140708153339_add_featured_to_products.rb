class AddFeaturedToProducts < ActiveRecord::Migration
  def change
    add_column :products, :listed, :boolean, :default => true
  end
end
