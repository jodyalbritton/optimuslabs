class RemoveFullNameFromContacts < ActiveRecord::Migration
  def change
  	    remove_column :contacts, :full_name
  end
end
