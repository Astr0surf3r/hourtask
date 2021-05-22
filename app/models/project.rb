class Project < ApplicationRecord

  has_many :tasks, dependent: :destroy
  has_many :payment_items
  belongs_to :company
 
end
