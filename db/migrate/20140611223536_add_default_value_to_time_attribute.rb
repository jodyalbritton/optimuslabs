class AddDefaultValueToTimeAttribute < ActiveRecord::Migration
  def change
  	    change_column :interactions, :time, :integer, :default => 0

  end
end
