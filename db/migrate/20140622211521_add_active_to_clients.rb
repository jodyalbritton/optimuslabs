class AddActiveToClients < ActiveRecord::Migration
  def change
    add_column :clients, :active, :boolean, :default => true
    add_reference :clients, :assigned_to, index: true
    add_reference :clients, :client_owner, index:true
  end
end
