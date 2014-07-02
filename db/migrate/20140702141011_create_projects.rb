class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.references :client, index: true
      t.string :name
      t.datetime :start_date
      t.datetime :end_date
      t.text :description
      t.references :category, index: true

      t.timestamps
    end
  end
end
