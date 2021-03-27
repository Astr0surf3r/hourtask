json.extract! task, :id, :day, :start_time, :end_time, :description, :project_id, :created_at, :updated_at
json.url task_url(task, format: :json)
