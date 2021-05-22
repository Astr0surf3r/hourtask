class CreatePaymentItems < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_items do |t|
      t.integer :payment_id
      t.integer :project_id
      t.float :hours_paid

      t.timestamps
    end
  end
end
