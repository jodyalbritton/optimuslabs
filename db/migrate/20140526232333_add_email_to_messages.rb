class AddEmailToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :email, :string
    add_reference :messages, :contact, index: true
  end
end
