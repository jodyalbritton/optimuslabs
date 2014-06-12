class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, :default => '', :null => false
      t.text :description
      t.integer :stock, :default => 0
      t.boolean :available, :default => false
      t.datetime :available_on
      t.string :slug
      t.string     :meta_description
      t.string     :meta_keywords
      t.string     :sku,   :default => '',    :null => false
      t.decimal :cost, :default => 0, :precision => 8, :scale => 2  
      t.decimal :price, :default => 0, :precision => 8, :scale => 2  

      t.timestamps
    end
    add_index :products, :slug, unique: true
  end
end
