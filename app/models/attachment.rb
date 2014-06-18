class Attachment < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true

  has_attached_file :file, :styles => { :medium => "300x300>",:small=> "150x150", :thumb => "50x50>" }, :default_url =>":style/missing.png"
  validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/

end
