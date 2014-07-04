class AddClosedAtToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :closed_at, :datetime
    add_column :tickets, :pended_at, :datetime
    add_column :tickets, :in_progress_at, :datetime
  end
end
