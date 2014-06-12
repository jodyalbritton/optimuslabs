class AddCategoryToProducts < ActiveRecord::Migration
  def change
  	 add_attachment :products, :photo
  	 add_column :products, :category_id, :integer
  end
end
