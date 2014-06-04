class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.string :summary
      t.text :description
      t.references :category, index: true
      t.timestamps
    end
  end
end
