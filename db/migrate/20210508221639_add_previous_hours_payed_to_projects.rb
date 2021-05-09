class AddPreviousHoursPayedToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :previous_hours_payed, :float
  end
end
