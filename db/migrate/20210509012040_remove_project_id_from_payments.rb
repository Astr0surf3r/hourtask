class RemoveProjectIdFromPayments < ActiveRecord::Migration[6.1]
  def change
    remove_column :payments, :project_id, :integer
  end
end
