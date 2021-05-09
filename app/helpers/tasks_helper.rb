module TasksHelper
  def calculate_previous_hours(project)
    if project.previous_hours_worked.nil?
      0
    else
      project.previous_hours_worked
    end
  end
end
