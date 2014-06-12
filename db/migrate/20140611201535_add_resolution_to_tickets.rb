class AddResolutionToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :resolution, :text
    add_column :tickets, :assignable_id, :integer
    add_column :tickets, :assignable_type, :string
  end
end
