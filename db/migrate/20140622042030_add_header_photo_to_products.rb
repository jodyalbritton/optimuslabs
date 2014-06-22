class AddHeaderPhotoToProducts < ActiveRecord::Migration
  def change
  	add_attachment :products, :header_photo
  	add_column :products, :featured, :boolean, :default => true
  end
end
