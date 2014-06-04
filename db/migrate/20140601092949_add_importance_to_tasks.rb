class AddImportanceToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :importance, :string
    add_column :tasks, :completed_at, :datetime
    add_column :tasks, :completed, :boolean
    add_reference :tasks, :client, index: true
    add_reference :tasks, :user, index: true
  end
end
