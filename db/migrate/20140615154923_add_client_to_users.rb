class AddClientToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :client, index: true
    add_column :users, :can_assign, :boolean
    add_column :users, :title, :string
    add_column :users, :active, :boolean
    add_column :users, :company, :string
    add_column :users, :country, :string
    add_column :users, :manager, :string
    add_column :users, :mobile_phone, :string
    add_column :users, :self_created, :boolean
  end
end
