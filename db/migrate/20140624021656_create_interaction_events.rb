class CreateInteractionEvents < ActiveRecord::Migration
  def change
    create_table :interaction_events do |t|
      t.string :name
      t.references :interaction
      t.text :description
      t.boolean :billable, :default => false

      t.timestamps
    end
  end
end
