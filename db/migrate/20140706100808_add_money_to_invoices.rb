class AddMoneyToInvoices < ActiveRecord::Migration
  def change
  	 add_money :invoices, :balance
  end
end
