class AddHourlyRateToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :hourly_rate, :decimal
  end
end
