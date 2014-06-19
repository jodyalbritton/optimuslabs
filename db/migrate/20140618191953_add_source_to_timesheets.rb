class AddSourceToTimesheets < ActiveRecord::Migration
  def change
    add_column :timesheets, :source, :string
  end
end
