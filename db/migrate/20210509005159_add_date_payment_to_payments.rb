class AddDatePaymentToPayments < ActiveRecord::Migration[6.1]
  def change
    add_column :payments, :date_payment, :datetime
  end
end
