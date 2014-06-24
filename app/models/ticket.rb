class Ticket < ActiveRecord::Base
  belongs_to :client
  belongs_to :severity_type
  belongs_to :ticket_status
  has_many :interactions, as: :interactive
  

  validates_presence_of :client
  validates_presence_of :subject
  validates_presence_of :description


  def get_label
  	if self.ticket_status.state == "Open"
  		"success"
    elsif self.ticket_status.state == "In Progress"
    	"warning"
    elsif self.ticket_status.state == "Pending"
    	"info"
    else	
        "default"
    end
  end
end
