class Invoice < ActiveRecord::Base
  monetize :balance_cents
  #### Include Acts as State Machine ####
  include AASM
  
  before_update :adjust_status
  ##### Database Relations #####

  has_many :items, dependent: :destroy, counter_cache: true
  has_many :notes, as: :notable, dependent: :destroy, counter_cache: true
  has_many :payments, as: :payable
  

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

   self.payments.sum(:amount_cents)



  end 
  def current_balance 
    (self.balance_cents - self.total_payments) / 100.00
   
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
  
  ###### Invoce States #####
   aasm do
    state :opened, :initial => true
    state :quoted
    state :in_progress
    state :paid

    event :progress, :after => Proc.new { collect_invoice } do
      transitions :from => [:opened, :quoted, :in_progress], :to => :in_progress
    end

    event :pay, :after => Proc.new { pay_invoice } do
      transitions :from => [:in_progress, :quoted], :to => :paid
    end

    event :open, :after => Proc.new { open_invoice } do
      transitions :from => [:quoted, :opened], :to => :opened
    end

    event :quote, :after => Proc.new { quote_invoice } do
      transitions :from => [:quoted, :opened], :to => :quoted

    end
  end

  def pay_invoice
      self.paid_on = Time.now
  end

  def quote_invoice
      self.quoted_on = Time.now
      
  end

  def open_invoice
    
  end

  def collect_invoice
    ##send notifications of balance due#####
  end

  def adjust_status
    case self.status
      when "paid"
       if self.paid? == false
        self.pay
       end
      when "in_progress"
       if self.in_progress? == false
        self.progress
       end
      when "quoted"
      if self.quoted? == false  
        self.quote
      end
      when "opened"
       if self.opened? == false 
        self.open
       end
    end
  end
####  Client Name Auto-complete ####
    def client_name
      self.client.try(:name)
    end

    def client_name=(name)
      self.client = Client.find_by(name: name) if name.present?
    end

end
