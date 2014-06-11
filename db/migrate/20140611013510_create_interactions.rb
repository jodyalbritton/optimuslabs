class CreateInteractions < ActiveRecord::Migration
  def change
    create_table :interactions do |t|
      t.integer :interactive_id
      t.string :interactive_type
      t.string :event

      t.timestamps
    end
  end
end
