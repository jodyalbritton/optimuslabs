class CreateSponsors < ActiveRecord::Migration
  def change
    create_table :sponsors do |t|
      t.string :name
      t.text :description
      t.references :category, index: true
      t.boolean :enabled

      t.timestamps
    end
  end
end
