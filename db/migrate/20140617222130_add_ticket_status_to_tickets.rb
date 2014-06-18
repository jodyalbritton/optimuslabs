class AddTicketStatusToTickets < ActiveRecord::Migration
  def change
    add_reference :tickets, :ticket_status, index: true
  end
end
