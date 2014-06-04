class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :type 

  
      t.references  :conversation, index: true
      t.references  :client, index: true
      t.references  :project, index: true
      t.references  :sender, :polymorphic => true
      t.string      :notification_code, :default => nil
      t.references  :notified_object, :polymorphic => true
      t.string      :source
      t.text        :body
      t.string      :subject
      t.boolean     :draft 
      t.column      :attachment, :string
      t.datetime    :expires

      t.timestamps
    end


  end
end
