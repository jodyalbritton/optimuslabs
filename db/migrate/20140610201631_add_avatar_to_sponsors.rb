class AddAvatarToSponsors < ActiveRecord::Migration
  def change
  	add_attachment :sponsors, :avatar
  end
end
