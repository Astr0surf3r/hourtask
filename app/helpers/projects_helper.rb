module ProjectsHelper
  
  def calculate_project_hours_worked(project)
    
    @project = project
  
    if @project.previous_hours_worked.nil?
      hours_worked = project.tasks.sum(:hours_worked)
    else
      hours_worked = @project.previous_hours_worked + @project.tasks.sum(:hours_worked)
    end 
  
  end
  
  def calculate_project_hours_paid(project)
  
    @project = project
    
    if @project.previous_hours_paid.nil?
      hours_payed = @project.payment_items.sum(:hours_paid)
    else
      hours_payed = @project.previous_hours_paid + @project.payment_items.sum(:hours_paid)
    end
  
  end
  
end
