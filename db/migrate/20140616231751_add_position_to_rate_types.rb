class AddPositionToRateTypes < ActiveRecord::Migration
  def change
    add_column :rate_types, :position, :integer
  end
end
