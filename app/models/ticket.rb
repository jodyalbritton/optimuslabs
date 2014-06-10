class Ticket < ActiveRecord::Base
  belongs_to :client


  validates_presence_of :client
  validates_presence_of :subject
  validates_presence_of :description
end
