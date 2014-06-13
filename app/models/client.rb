class Client < ActiveRecord::Base
	has_attached_file :avatar, :styles => { :large => "600x600", :medium => "300x300>", :thumb => "100x100>" }, :default_url => ":style/missing.png"
  	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  	has_many :notes, as: :notable
  	has_many :invoices
  	has_many :tickets
  	has_many :tasks
  	has_many :contacts
end
