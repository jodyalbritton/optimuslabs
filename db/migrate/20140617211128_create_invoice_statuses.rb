class CreateInvoiceStatuses < ActiveRecord::Migration
  def change
    create_table :invoice_statuses do |t|
      t.string :state
      t.text :description
      t.integer :position

      t.timestamps
    end
  end
end
