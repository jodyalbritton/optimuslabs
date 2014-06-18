class AddInvoiceStatusToInvoices < ActiveRecord::Migration
  def change
    add_reference :invoices, :invoice_status, index: true
  end
end
