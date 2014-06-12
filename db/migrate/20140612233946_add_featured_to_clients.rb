class AddFeaturedToClients < ActiveRecord::Migration
  def change
    add_column :clients, :featured, :boolean, :default => false 
  end
end
