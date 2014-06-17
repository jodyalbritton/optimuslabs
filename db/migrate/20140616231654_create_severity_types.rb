class CreateSeverityTypes < ActiveRecord::Migration
  def change
    create_table :severity_types do |t|
      t.string :name
      t.text :description
      t.integer :position

      t.timestamps
    end
  end
end
