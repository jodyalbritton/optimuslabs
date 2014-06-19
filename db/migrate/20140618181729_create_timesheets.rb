class CreateTimesheets < ActiveRecord::Migration
  def change
    create_table :timesheets do |t|
      t.datetime :clocked_in
      t.datetime :clocked_out
      t.references :user, index: true

      t.timestamps
    end
  end
end
