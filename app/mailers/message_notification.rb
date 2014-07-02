class MessageNotification < ActionMailer::Base
  default from: "info@getoptimus.com"

  def new_message(message)
    @message = message
    
    mail(to: Setting.company_email, subject: @message.subject)
  end
end
