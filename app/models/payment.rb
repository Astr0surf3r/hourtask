class Payment < ApplicationRecord
 
  belongs_to :project
  has_many :payment_items
  
end
