class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.decimal :amount
      t.string :currency
      t.string :payment_method
      t.integer :project_id

      t.timestamps
    end
  end
end
