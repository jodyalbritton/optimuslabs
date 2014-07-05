class Sponsor < ActiveRecord::Base
 extend FriendlyId
  has_attached_file :avatar, :styles => { :large => "600x403#", :medium => "300x300#", :thumb => "100x100>" }, :default_url => ":style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  friendly_id :name, use: :slugged

  belongs_to :category

  def category_name
  self.category.try(:name)
  end

  def category_name=(name)
  self.category = Category.find_or_create_by(name: name) if name.present?
  end

end
