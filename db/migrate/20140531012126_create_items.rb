class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.decimal :cost
      t.string :name
      t.text :description
      t.integer :item_num
      t.integer :quantity 
      t.belongs_to :invoice 
      t.references :purchasable, polymorphic: true

      t.timestamps
    end
  end
end
