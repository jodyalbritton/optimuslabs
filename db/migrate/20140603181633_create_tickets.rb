class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :subject
      t.references :client, index: true
      t.text :description
      t.string :severity
      t.string :status
      t.string :location

      t.timestamps
    end
  end
end
