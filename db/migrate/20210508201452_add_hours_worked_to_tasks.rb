class AddHoursWorkedToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :hours_worked, :float
  end
end
