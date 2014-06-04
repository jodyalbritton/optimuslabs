class AddLogoToClients < ActiveRecord::Migration
  def change
    add_column :clients, :url, :string
    add_attachment :clients, :avatar
  end
  def self.down
    remove_attachment :clients, :avatar
    remove_column :clients, :url
  end
end
