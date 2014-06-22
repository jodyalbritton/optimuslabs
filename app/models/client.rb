class Client < ActiveRecord::Base
	has_attached_file :avatar, :styles => { :large => "600x600", :medium => "300x300#", :thumb => "100x100#" }, :default_url => ":style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  	has_many :notes, as: :notable
  	has_many :invoices
  	has_many :tickets
  	has_many :tasks
  	has_many :contacts
  	has_many :users

    belongs_to :assigned_to, :class_name => "User"
    belongs_to :client_owner, :class_name => "User"



    has_many :contact_interactions, :through => :contacts, :source => :interactions
  	has_many :ticket_interactions, :through => :tickets, :source => :interactions
    

  	
    def total_interactions
      a= self.contact_interactions.sum :time 
      b= self.ticket_interactions.sum :time
      a + b

    end 


  	 

end
