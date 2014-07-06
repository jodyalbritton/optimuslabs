class RemoveAmountFromPayments < ActiveRecord::Migration
  def change
    remove_column :payments, :amount
    remove_column :invoices, :balance
  end
end
