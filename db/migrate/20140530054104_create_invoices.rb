class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :subject
      t.references :client, index: true
      t.date :started_on
      t.date :completed_on
      t.decimal :total
      t.text :notes
      t.string :attention
      t.integer :inv_number
      t.decimal :balance
      t.boolean :paid

      t.timestamps
    end
  end
end
