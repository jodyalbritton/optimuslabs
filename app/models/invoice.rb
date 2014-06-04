class Invoice < ActiveRecord::Base
  belongs_to :client
  has_many :items
  has_many :notes, as: :notable

  accepts_nested_attributes_for :items, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :notes, :reject_if => :all_blank, :allow_destroy => true

  attr_accessor :purchasable_identifier

 


  def total_price
  	total_items = self.items 
  	total_price = 0.0
    
    total_items.each do |item|

	  	unless item.purchasable.price == nil 
	  	total_price =  total_price+(item.purchasable.price*item.quantity)
	  	end

    end

    sprintf("%.02f",total_price)
 	
  end

end
