class AddSeverityTypesToTickets < ActiveRecord::Migration
  def change
    add_reference :tickets, :severity_type, index: true
  end
end
