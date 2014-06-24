class AddSummaryToProducts < ActiveRecord::Migration
  def change
    add_column :products, :summary, :text
  end
end
