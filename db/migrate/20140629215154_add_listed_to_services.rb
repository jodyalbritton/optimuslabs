class AddListedToServices < ActiveRecord::Migration
  def change
    add_column :services, :listed, :boolean, :default => false
  end
end
