class Item < ActiveRecord::Base

	belongs_to :invoice
	belongs_to :purchasable, :polymorphic => true
    

	attr_accessor :target_identifier

    def target_identifier
      
      "#{purchasable.class.to_s}-#{purchasable_id}"

    end

    def line_total
      sprintf("%.02f",self.purchasable.price * self.quantity)
    end 

    def target_identifier=(target_data)
      if target_data.present?
         target_data = target_data.split('-')
        self.purchasable_type = target_data[0]
        self.purchasable_id = target_data[1]
      end
    end

end
