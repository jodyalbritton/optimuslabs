class Admin::TicketMailer < ActionMailer::Base
  default from: Setting.company_email

  def ticket_created(ticket)
    @ticket = ticket
    @url  = Setting.company_url 
    mail(to: @ticket.client.email, subject: 'Support Ticket #'+@ticket.id.to_s)
  end

  def ticket_updated(ticket)
    @ticket = ticket
    @url  = Setting.company_url 
    mail(to: @ticket.client.email, subject: 'Support Ticket #'+@ticket.id.to_s)
  end
end
