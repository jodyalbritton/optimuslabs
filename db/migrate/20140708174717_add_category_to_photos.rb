class AddCategoryToPhotos < ActiveRecord::Migration
  def change
    add_reference :photos, :category, index: true
    add_reference :photos, :gallery, index: true
    add_reference :videos, :gallery, index: true
  end
end
