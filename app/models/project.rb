class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :payments
  belongs_to :company

end
