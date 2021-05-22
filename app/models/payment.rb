class Payment < ApplicationRecord
 
  has_many :payment_items, dependent: :destroy
  
end
