class Event < ActiveRecord::Base
  belongs_to :client
  belongs_to :created_by
end
