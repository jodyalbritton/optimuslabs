class AddInteractionEventsToInteractions < ActiveRecord::Migration
  def change
    add_reference :interactions, :interaction_event, index: true
  end
end
