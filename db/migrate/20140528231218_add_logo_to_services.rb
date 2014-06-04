class AddLogoToServices < ActiveRecord::Migration
  def change
    add_column :services, :logo_icon, :string
    add_attachment :services, :logo
    add_attachment :services, :header
    add_column :services, :price, :decimal, :precision => 30, :scale => 10
    add_column :services, :cost, :decimal, :precision => 30, :scale => 10
    add_column :services, :duration, :decimal, :precision => 30, :scale => 10
 	



  end
end
