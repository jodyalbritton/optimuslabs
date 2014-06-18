class CreateTicketStatuses < ActiveRecord::Migration
  def change
    create_table :ticket_statuses do |t|
      t.string :state
      t.text :description
      t.integer :position

      t.timestamps
    end
  end
end
