class AddWorkedHoursToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :worked_hours, :float
  end
end
