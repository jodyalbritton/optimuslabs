class Invoice < ActiveRecord::Base
  
  ##### Database Relations #####

  has_many :items, dependent: :destroy, counter_cache: true
  has_many :notes, as: :notable, dependent: :destroy, counter_cache: true
  has_many :payments
  

  belongs_to :client
  belongs_to :invoice_status
  before_save :update_balance

  accepts_nested_attributes_for :items, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :notes, :reject_if => :all_blank, :allow_destroy => true

  attr_accessor :purchasable_identifier

 
  
#### Payment and Balance ####

  def update_balance
    self.balance = self.total_price
  end

  
  def total_payments

   self.payments.sum :amount



  end 
  def current_balance 
    
   sprintf("%.02f", balance - total_payments)
  end 

  def total_price
  	total_items = self.items 
  	total_price = 0.0
    
    total_items.each do |item|

	  	unless item.price == nil 
	  	total_price =  total_price+(item.price*item.quantity)
	  	end

    end

    sprintf("%.02f",total_price)
 	
  end

####  Client Name Auto-complete ####
    def client_name
      self.client.try(:name)
    end

    def client_name=(name)
      self.client = Client.find_by(name: name) if name.present?
    end

end
