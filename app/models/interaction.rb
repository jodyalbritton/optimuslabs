class Interaction < ActiveRecord::Base
	belongs_to :interactive, polymorphic: true 
	belongs_to :interaction_event



	def interaction_event_name
	  self.interaction_event.try(:name)
	end

	def interaction_event_name=(name)
	  self.interaction_event = InteractionEvent.find_or_create_by(name: name) if name.present?
	end
end
