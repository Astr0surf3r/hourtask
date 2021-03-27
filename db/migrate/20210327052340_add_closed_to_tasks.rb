class AddClosedToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :closed, :boolean, default: false
  end
end
