class ChangeBalanceTypeOnInvoices < ActiveRecord::Migration
  def change
  	change_column :invoices, :balance, :decimal, :precision => 8, :scale => 2
  	change_column :invoices, :total, :decimal, :precision => 8, :scale => 2
  end
end
