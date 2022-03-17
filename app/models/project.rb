class Project < ApplicationRecord

  has_many :tasks, dependent: :destroy
  has_many :payment_items, dependent: :destroy
  has_many :discounts, dependent: :destroy

  belongs_to :company

end
