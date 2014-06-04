class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :subject
      t.string :body
      t.references :created_by, index: true
      t.references :notable, polymorphic: true

      t.timestamps
    end
  end
end
