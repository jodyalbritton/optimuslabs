class AddRateTypeToServices < ActiveRecord::Migration
  def change
    add_reference :services, :rate_type, index: true
  end
end
