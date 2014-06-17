class Ticket < ActiveRecord::Base
  belongs_to :client
  belongs_to :severity_type
  has_many :interactions, as: :interactive


  validates_presence_of :client
  validates_presence_of :subject
  validates_presence_of :description


  def get_label
  	if self.status == "Open"
  		"success"
    elsif self.status == "In Progress"
    	"warning"
    elsif self.status == "Pending"
    	"info"
    else	
        "default"
    end
  end
end
