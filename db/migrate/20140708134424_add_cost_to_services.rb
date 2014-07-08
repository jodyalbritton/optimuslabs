class AddCostToServices < ActiveRecord::Migration
  def change
  	remove_column :services, :cost
  	remove_column :services, :price
    remove_column :products, :cost
    remove_column :products, :price

    add_money :products, :cost
    add_money :products, :price
    add_money :services, :price
    add_money :services, :cost

 

  end
end
