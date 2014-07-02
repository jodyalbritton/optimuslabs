class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.datetime :start_date
      t.datetime :end_date
      t.references :client, index: true
      t.references :created_by, index: true

      t.timestamps
    end
  end
end
