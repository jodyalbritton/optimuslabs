class PaymentMethod < ActiveRecord::Base
	acts_as_list
	has_many :payments
end
