class AddSponsorToVideos < ActiveRecord::Migration
  def change
    add_reference :videos, :sponsor, index: true
    add_column :videos, :sponsored, :boolean, :default => false
    add_column :videos, :embed, :text
    add_column :videos, :url, :string
    add_column :videos, :description, :text

  end
end
