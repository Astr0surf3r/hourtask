class RemoveWorkedHoursFromTasks < ActiveRecord::Migration[6.1]
  def change
    remove_column :tasks, :worked_hours, :float
  end
end
