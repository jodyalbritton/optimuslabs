class AddBannerToSponsors < ActiveRecord::Migration
  def change
    add_attachment :sponsors, :banner
  end
end
