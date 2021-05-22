class AddPreviousHoursPaidToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :previous_hours_paid, :float
  end
end
