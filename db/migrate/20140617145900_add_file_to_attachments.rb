class AddFileToAttachments < ActiveRecord::Migration
  def change
  	add_attachment :attachments, :file
  end
end
