class AddReasonToDiscounts < ActiveRecord::Migration[6.1]
  def change
    add_column :discounts, :reason, :string
  end
end
