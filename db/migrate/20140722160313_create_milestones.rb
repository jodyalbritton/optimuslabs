class CreateMilestones < ActiveRecord::Migration
  def change
    create_table :milestones do |t|
      t.references :project, index: true
      t.text :description
      t.datetime :completed_at

      t.timestamps
    end
  end
end
