class PaymentItem < ApplicationRecord
  
  belongs_to :payment
  belongs_to :project

end
