class Client < ActiveRecord::Base
	has_attached_file :avatar, :styles => { :large => "600x600", :medium => "300x300#", :thumb => "100x100#" }, :default_url => ":style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  	has_many :notes, as: :notable
  	has_many :invoices
  	has_many :tickets
  	has_many :tasks
  	has_many :contacts
  	has_many :users
    has_many :payments, as: :source 

    belongs_to :assigned_to, :class_name => "User"
    belongs_to :client_owner, :class_name => "User"



    has_many :contact_interactions, :through => :contacts, :source => :interactions
  	has_many :ticket_interactions, :through => :tickets, :source => :interactions
    has_many :user_interactions, :through => :users, :source => :interactions
    

  	
    def total_interaction_time
        a = self.contact_interactions.sum :time
        b = self.ticket_interactions.sum :time
        c = self.user_interactions.sum :time

        a + b + c
    

    end 

    def all_interactions 
      self.contact_interactions + self.ticket_interactions + self.user_interactions
    end


   

  	 

end
