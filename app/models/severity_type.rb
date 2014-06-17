class SeverityType < ActiveRecord::Base
	has_many :tickets
end
