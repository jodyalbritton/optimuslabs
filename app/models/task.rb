class Task < ActiveRecord::Base
	acts_as_list
	belongs_to :client

end
