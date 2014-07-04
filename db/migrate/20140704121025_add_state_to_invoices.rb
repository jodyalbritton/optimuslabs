class AddStateToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :aasm_state, :string
    add_column :invoices, :paid_on, :datetime
    add_column :invoices, :quoted_on, :datetime
  end
end
