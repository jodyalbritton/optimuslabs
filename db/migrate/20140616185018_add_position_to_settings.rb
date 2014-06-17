class AddPositionToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :position, :integer
  end
end
