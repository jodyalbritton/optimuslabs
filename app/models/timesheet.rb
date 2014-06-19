class Timesheet < ActiveRecord::Base
  belongs_to :user


  def time_worked
  	if self.clocked_in == nil || self.clocked_out == nil
  		Time.now - self.clocked_in
  		
  	else 
  		self.clocked_out - self.clocked_in

  	end
  end 
end
