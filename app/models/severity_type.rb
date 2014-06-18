class SeverityType < ActiveRecord::Base
	acts_as_list
	has_many :tickets
end
