class CreateDiscounts < ActiveRecord::Migration[6.1]
  def change
    create_table :discounts do |t|
      t.float :discounted_hours
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
