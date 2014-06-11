class AddContentToInteractions < ActiveRecord::Migration
  def change
    add_column :interactions, :content, :text
  end
end
