class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.date :day
      t.time :start_time
      t.time :end_time
      t.string :description
      t.integer :project_id

      t.timestamps
    end
  end
end
