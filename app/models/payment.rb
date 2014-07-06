class Payment < ActiveRecord::Base
  monetize :amount_cents
  belongs_to :payable, polymorphic: true
  belongs_to :source, polymorphic: true
  belongs_to :payment_method

  def get_payment_source
  	if self.source_type == "Client"
  		self.source.name
    else 
        "Unknown"
    end
  end 

  def get_payable_for
  	if self.payable_type == "Invoice"
  		self.payable.subject
    end
  end 
end
