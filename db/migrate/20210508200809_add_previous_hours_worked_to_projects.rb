class AddPreviousHoursWorkedToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :previous_hours_worked, :float
  end
end
