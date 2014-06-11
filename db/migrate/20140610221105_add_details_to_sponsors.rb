class AddDetailsToSponsors < ActiveRecord::Migration
  def change
    add_column :sponsors, :url, :string
    add_column :sponsors, :video_url, :string
    add_column :sponsors, :phone, :string
    add_column :sponsors, :email, :string
    add_reference :sponsors, :client, index: true
    add_column :sponsors, :address, :string
    add_column :sponsors, :city, :string
    add_column :sponsors, :state, :string
    add_column :sponsors, :zip, :string
  end
end
