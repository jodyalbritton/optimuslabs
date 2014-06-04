class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :full_name
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.references :client, index: true
      t.text :notes
      t.string :customer_number
      t.datetime :customer_since 
      t.string :first_interaction

      t.timestamps
    end
  end
end
