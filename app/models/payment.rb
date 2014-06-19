class Payment < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :source, polymorphic: true
end
