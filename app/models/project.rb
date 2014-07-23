class Project < ActiveRecord::Base
  belongs_to :client
  belongs_to :category
  has_many :milestones

  	#### Validations ####
  	validates_presence_of :name, :client_name, :description
    ####  Client Name Auto-complete ####
    def client_name
      self.client.try(:name)
    end

    def client_name=(name)
      self.client = Client.find_by(name: name) if name.present?
    end
end
