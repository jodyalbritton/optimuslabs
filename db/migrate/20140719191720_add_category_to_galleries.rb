class AddCategoryToGalleries < ActiveRecord::Migration
  def change
    add_reference :galleries, :category, index: true
  end
end
