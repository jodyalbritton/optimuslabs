class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.date :published_at
      t.references :author, index: true
      t.boolean :draft
      t.text :excerpt
      add_reference :posts, :category, index: true
      t.timestamps
    end
  end
end
