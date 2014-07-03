class ChatMessage < ActiveRecord::Base
  belongs_to :user

  attr_accessor :name
end 