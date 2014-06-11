class Ticket < ActiveRecord::Base
  belongs_to :client
  has_many :interactions, as: :interactive


  validates_presence_of :client
  validates_presence_of :subject
  validates_presence_of :description
end
