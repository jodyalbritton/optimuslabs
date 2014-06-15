class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.decimal    :amount, :precision => 8, :scale => 2, :default => 0.0, :null => false
      t.references :invoice, index: true
      t.references :source, :polymorphic => true
      t.references :payment_method
      t.string     :state
      t.string     :response_code
      t.string     :avs_response

      t.timestamps
    end
  end
end
